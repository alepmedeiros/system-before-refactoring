unit UConsultaPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls, Grids, DBGrids, FMTBcd, DB, SqlExpr,
  ComCtrls, ActnList, DBClient, Provider, ComObj, AppEvnts, Menus, SimpleDS,
  JvExControls, JvGradientHeaderPanel, RecError ;

type
  TConsultaPadraoForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    CBCriterio: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    CBCondicao: TComboBox;
    EditValor: TEdit;
    Label3: TLabel;
    DBGrid1: TDBGrid;
    qryConsulta: TSQLQuery;
    DSqryConsulta: TDataSource;
    SBPrincipal: TStatusBar;
    qryControleAcesso: TSQLQuery;
    qryControleAcessoUSUARIO_ACESSO_ID: TIntegerField;
    qryControleAcessoUSUARIO_ID: TIntegerField;
    qryControleAcessoTABELA: TStringField;
    qryControleAcessoDESCRICAO: TStringField;
    qryControleAcessoVALOR: TSmallintField;
    qryControleAcessoTIPO: TStringField;
    ActionList: TActionList;
    ASair: TAction;
    qryExportar: TSQLQuery;
    DSPExportar: TDataSetProvider;
    CDSExportar: TClientDataSet;
    ApplicationEvents: TApplicationEvents;
    PopupMenu1: TPopupMenu;
    DSPConsulta: TDataSetProvider;
    CDSConsulta: TClientDataSet;
    ExibirColunas1: TMenuItem;
    ReconfigurarColunas1: TMenuItem;
    qryCsExibirColuna: TSQLQuery;
    GHPPrincipal: TJvGradientHeaderPanel;
    BTNovo: TSpeedButton;
    BTAlterar: TSpeedButton;
    BTExcluir: TSpeedButton;
    BTExportar: TSpeedButton;
    BTSair: TSpeedButton;
    BTPesquisar: TSpeedButton;
    CBSituacao: TComboBox;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BTExportarClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure BTSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExibirColunas1Click(Sender: TObject);
    procedure CBCriterioSelect(Sender: TObject);
    procedure CBCondicaoSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BTExcluirClick(Sender: TObject);
    procedure ReconfigurarColunas1Click(Sender: TObject);
    procedure CDSConsultaReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure BTAlterarClick(Sender: TObject);
    procedure ASairExecute(Sender: TObject);
  private
    { Private declarations }
    Id : Integer;
    Descricao : ShortString;
    FBarraStatus : Boolean;
    Form : TForm;
    FormClass: TFormClass;
    procedure CarregaPermissoes;
    procedure CarregaPreferencias;
    procedure CarregaHint;
  public
    { Public declarations }
  published
    { Published declarations }
    property BarraStatus: Boolean read FBarraStatus write FBarraStatus;
  end;

var
  ConsultaPadraoForm: TConsultaPadraoForm;

implementation
uses Base, UFuncoes, UFuncaoExibirColuna, UsuarioExibirColuna;
{$R *.dfm}

procedure TConsultaPadraoForm.CarregaPermissoes;
const
  Privilegios: Array[1..5] of String = ('Formulario', 'Novo', 'Excluir', 'Editar', 'Exportar');
var
  i : Integer;
begin
  GeraTrace(BancoDados.Tabela,'Carregando Permiss?es do Usu?rio');

  BancoDados.CDSPrivilegio.Close;
  BancoDados.qryPrivilegio.SQL.Text := 'select * from privilegio where tabela = ' +
    QuotedStr(BancoDados.Tabela);
  BancoDados.CDSPrivilegio.Open;

  for i := 1 to 5 do
    begin
      BancoDados.CDSPrivilegio.First;
      while not BancoDados.CDSPrivilegio.Eof do
        begin
          if (BancoDados.CDSPrivilegioABREVIACAO.Value = Privilegios[i]) then
            begin
              with BancoDados.qryExecute do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('select acesso from usuario_privilegio where usuario_id = ' +
                    IntToStr(BancoDados.qryLoginUSUARIO_ID.Value) + ' and privilegio_id = ' +
                    IntToStr(BancoDados.CDSPrivilegioPRIVILEGIO_ID.Value));
                  Open;
                end;
              if (Privilegios[i] = 'Formulario') then
                BancoDados.LiberaFormulario := (BancoDados.qryExecute.Fields[0].Value = 1)
              else if (Privilegios[i] = 'Novo') then
                BTNovo.Enabled := (BancoDados.qryExecute.Fields[0].Value = 1)
              else if (Privilegios[i] = 'Excluir') then
                BTExcluir.Enabled := (BancoDados.qryExecute.Fields[0].Value = 1)
              else if (Privilegios[i] = 'Editar') then
                begin
                  if (BancoDados.qryExecute.Fields[0].Value = 1) then
                    begin
                      BTAlterar.Caption := 'Alterar';
                      BancoDados.LiberaAlterar := True;
                    end
                  else
                    begin
                      BTAlterar.Caption := 'Visualizar';
                      BancoDados.LiberaAlterar := False;
                    end;
                end
              else if (Privilegios[i] = 'Exportar') then
                begin
                  if (BancoDados.qryExecute.Fields[0].Value = 1) then
                    begin
                      BTExportar.Enabled := True;
                      BancoDados.LiberaExportar := True;
                    end
                  else
                    begin
                      BTExportar.Enabled := False;
                      BancoDados.LiberaExportar := False;
                    end;
                end;
            end;
          BancoDados.CDSPrivilegio.Next;
        end;
    end;
  GeraTrace(BancoDados.Tabela,'Permiss?es do Usu?rio Carregadas');
end;

procedure TConsultaPadraoForm.CarregaPreferencias;
begin
  CBCriterio.ItemIndex := StrToInt(LerOpcaoUsuario(BancoDados.qryExecute,
    BancoDados.qryLoginUSUARIO_ID.Value, 1, 'Consulta - Crit?rio', '0', BancoDados.Tabela));

  CBSituacao.ItemIndex := StrToInt(LerOpcaoUsuario(BancoDados.qryExecute, BancoDados.qryLoginUSUARIO_ID.Value, 2,
    'Consulta - Ativo', '0', BancoDados.Tabela));
end;

procedure TConsultaPadraoForm.CarregaHint;
begin
  CBCriterio.Hint := 'Informe o Campo para a Consulta.';
  CBCondicao.Hint := 'Informe a Condi??o para a Consulta.';
  EditValor.Hint := 'Informe o Valor a ser Consultado.';
  BTPesquisar.Hint := 'Acionar Consulta.';
  CBSituacao.Hint := 'Registrios a serem Consultados (Somente Ativos/Inativos/Todos).';
  BTNovo.Hint := 'Novo Registro.';
  BTAlterar.Hint := 'Alterar Registro.';
  BTExcluir.Hint := 'Excluir Registro.';
  BTExportar.Hint := 'Exportar Registros para o Excel.';
  BTSair.Hint := 'Sair da Tela.';
end;

procedure TConsultaPadraoForm.ExibirColunas1Click(Sender: TObject);
begin
  try
    GeraTrace(BancoDados.Tabela,'Alterando Configura??es da Grade');
    FBarraStatus := False;

    if not Assigned(UsuarioExibirColunaForm) then
      UsuarioExibirColunaForm := TUsuarioExibirColunaForm.Create(Application);
    UsuarioExibirColunaForm.ShowModal;
    UsuarioExibirColunaForm.TabelaFuncao := 0;
  finally
    FBarraStatus := True;
    ConfiguraGrade(DBGrid1, BancoDados.qryLoginUSUARIO_ID.Value, 0, BancoDados.Tabela);

    UsuarioExibirColunaForm.Free;
    UsuarioExibirColunaForm := nil;
    GeraTrace(BancoDados.Tabela,'Configura??es da Grade Alteradas');
  end;
end;

procedure TConsultaPadraoForm.CBCondicaoSelect(Sender: TObject);
begin
  EditValor.SetFocus;
end;

procedure TConsultaPadraoForm.CBCriterioSelect(Sender: TObject);
begin
  EditValor.SetFocus;
end;

procedure TConsultaPadraoForm.CDSConsultaReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  if (Pos('FOREIGN KEY', E.Message) > 0) then
    begin
      Mensagem('N?o foi poss?vel excluir este Registro: ' + #13 +
        'Existem lan?amentos feitos apartir do mesmo!', mtWarning,[mbOk],mrOK,0);
    end;

  DataSet.Cancel;
  CDSConsulta.Close;
  CDSConsulta.Open;
end;

procedure TConsultaPadraoForm.ApplicationEventsHint(Sender: TObject);
begin
  if (FBarraStatus) then
    SBPrincipal.Panels[0].Text := Application.Hint;
end;

procedure TConsultaPadraoForm.ASairExecute(Sender: TObject);
begin
  BTSairClick(Sender);
end;

procedure TConsultaPadraoForm.BTAlterarClick(Sender: TObject);
begin
  if (CDSConsulta.IsEmpty) then
    begin
      Mensagem('N?o h? Registro a ser Alterado!', mtWarning,[mbOk],mrOK,0);
      Abort;
    end;
end;

procedure TConsultaPadraoForm.BTExcluirClick(Sender: TObject);
begin
  try
    GeraTrace(BancoDados.Tabela,'Excluindo Registros');
    BancoDados.Conexao.StartTransaction(BancoDados.Transacao);
    if (Mensagem('Deseja realmente Excluir este Registro?',mtConfirmation,[mbYES,mbNO],mrNO,0) = idYES) then
      begin
        CDSConsulta.Delete;
        CDSConsulta.ApplyUpdates(0);
        BancoDados.Conexao.Commit(BancoDados.Transacao);
      end
    else
      Abort;
    GeraTrace(BancoDados.Tabela,'Exclus?o Concluida');
  except
      CDSConsulta.Cancel;
      BancoDados.Conexao.Rollback(BancoDados.Transacao);
  end;
end;

procedure TConsultaPadraoForm.BTExportarClick(Sender: TObject);
var
  Linha, Coluna : integer;
  Planilha: Variant;
  ValorCampoEx: ShortString;
begin
  CDSExportar.Close;
  qryExportar.SQL.Text := 'select * from ' + BancoDados.Tabela;
  CDSExportar.Open;

  if not (CDSExportar.IsEmpty) then
    begin
      GeraTrace(BancoDados.Tabela,'Exportando Dados para o Excel');
      Planilha := CreateOleObject('Excel.Application');
      Planilha.workBooks.add(1);
      Planilha.caption := 'Exporta??o de dados para excel' ;
      Planilha.visible := True;
      CDSExportar.First;

      for Linha := 0 to CDSExportar.RecordCount - 1 do
        begin
          for coluna := 1 to CDSExportar.FieldCount do
            begin
              ValorCampoEx := CDSExportar.Fields[coluna - 1].AsString;
              Planilha.cells[Linha + 2, Coluna] := ValorCampoEx;
            end;
         CDSExportar.Next;
        end;

      for coluna := 1 to CDSExportar.FieldCount do
        begin
          ValorCampoEx := CDSExportar.Fields[coluna - 1].DisplayLabel;
          Planilha.cells[1, Coluna] := ValorCampoEx;
        end;

      Planilha.columns.Autofit;

      GeraTrace(BancoDados.Tabela,'Dados Exportados com Sucesso');
      Log(BancoDados.qryLog, BancoDados.qryLoginUSUARIO_ID.Value, BancoDados.Tabela,
        'Registro Exportado: ' + IntToStr(Id) + '/' + Descricao + '.');
    end
  else
    Mensagem('N?o h? itens para exportar !', mtWarning,[mbOk],mrOK,0);
end;

procedure TConsultaPadraoForm.BTSairClick(Sender: TObject);
begin
  Close;
end;

procedure TConsultaPadraoForm.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Check : Integer;
  R: TRect;
begin
  if (Column.FieldName = 'ATIVO') then
    begin
      DBGrid1.Canvas.FillRect(Rect);
      Check := 0;
      if (CDSConsulta.FieldByName('ATIVO').Value = 1) then
        Check := DFCS_CHECKED
      else
        Check := 0;
      R := Rect;
      InflateRect(R,-3,-3);
      DrawFrameControl(DBGrid1.Canvas.Handle,R,DFC_BUTTON, DFCS_BUTTONCHECK or Check);
    end;
end;

procedure TConsultaPadraoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Valor : Integer;
begin
  GravarOpcaoUsuario(BancoDados.qryExecute, BancoDados.qryLoginUSUARIO_ID.Value, 1,
    IntToStr(CBCriterio.ItemIndex), BancoDados.Tabela);
  
  GravarOpcaoUsuario(BancoDados.qryExecute, BancoDados.qryLoginUSUARIO_ID.Value, 2,
    IntToStr(CBSituacao.ItemIndex), BancoDados.Tabela);

  qryConsulta.Close;
  qryControleAcesso.Close;
  BancoDados.LiberaFormulario := False;
  BancoDados.LiberaAlterar := False;
  BancoDados.LiberaExportar := False;
  BancoDados.Operacao := '';
  BancoDados.Tabela := '';

  GeraTrace(BancoDados.Tabela,'Formul?rio de Consulta Encerrado');
  GeraTrace(BancoDados.Tabela,CriaLinha(110));
end;

procedure TConsultaPadraoForm.FormCreate(Sender: TObject);
begin
  ApplicationEvents.Activate;
  CarregaPermissoes;
end;

procedure TConsultaPadraoForm.FormShow(Sender: TObject);
var
  Valor : Boolean;
begin
  AtivaTrace := (Trace(BancoDados.qryExecute, BancoDados.Tabela) = 1);
  GeraTrace(BancoDados.Tabela,CriaLinha(110));
  GeraTrace(BancoDados.Tabela,'Abrindo Formul?rio de Consulta');

  BancoDados.Operacao := '';

  FBarraStatus := True;
  CarregaPreferencias;
  CarregaHint;

  EditValor.SetFocus;

  BancoDados.CDSTabela.Close;
  BancoDados.qryTabela.SQL.Text := 'select * from tabela where tabela = ' +
    QuotedStr(BancoDados.Tabela);
  BancoDados.CDSTabela.Open;

  Caption := 'MasterERP - ' + BancoDados.CDSTabelaDESCRICAO_REDUZIDA.Value;
  GHPPrincipal.LabelCaption := BancoDados.CDSTabelaDESCRICAO_REDUZIDA.Value;

  ConfiguraGrade(DBGrid1, BancoDados.qryLoginUSUARIO_ID.Value, 0, BancoDados.Tabela);
  GeraTrace(BancoDados.Tabela,'Formul?rio de Consulta');
end;

procedure TConsultaPadraoForm.ReconfigurarColunas1Click(Sender: TObject);
begin
  try
    GeraTrace(BancoDados.Tabela,'Alterando Configura??es da Grade');
    BancoDados.CDSUsuarioExibir.Close;
    BancoDados.qryUsuarioExibir.SQL.Text := 'select * from usuario_exibir ' +
      ' where usuario_id = ' + IntToStr(BancoDados.qryLoginUSUARIO_ID.Value) +
      ' and tabela = ' + QuotedStr(BancoDados.Tabela) + ' and tabela_funcao = ' +
      IntToStr(0);
    BancoDados.CDSUsuarioExibir.Open;

    BancoDados.Conexao.StartTransaction(BancoDados.Transacao);

    BancoDados.qryExecute.SQL.Text := 'delete from usuario_exibir_coluna where usuario_exibir_id = ' +
      IntToStr(BancoDados.CDSUsuarioExibirUSUARIO_EXIBIR_ID.Value) + ';';
    BancoDados.qryExecute.ExecSQL(True);

    BancoDados.qryExecute.SQL.Text := 'delete from usuario_exibir where usuario_exibir_id = ' +
      IntToStr(BancoDados.CDSUsuarioExibirUSUARIO_EXIBIR_ID.Value) + ';';
    BancoDados.qryExecute.ExecSQL(True);

    BancoDados.Conexao.Commit(BancoDados.Transacao);

    ConfiguraGrade(DBGrid1, BancoDados.qryLoginUSUARIO_ID.Value, 0, BancoDados.Tabela);

    Mensagem('Altera??es gravadas com Sucesso!', mtInformation,[mbOk],mrOK,0);

    GeraTrace(BancoDados.Tabela,'Configura??es da Grade Alteradas');

  except
    Mensagem('Erro ao tentar Reconfigurar a Grade!', mtWarning,[mbOk],mrOK,0);
    BancoDados.Conexao.Rollback(BancoDados.Transacao);
    Abort;
  end;
end;

end.
