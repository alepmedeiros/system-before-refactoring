unit UConsultaGrupoProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UConsultaPadrao, FMTBcd, Menus, AppEvnts, DBClient, Provider,
  ActnList, DB, SqlExpr, ComCtrls, StdCtrls, Grids, DBGrids, Buttons,
  JvExControls, JvGradientHeaderPanel, ExtCtrls;

type
  TConsultaGrupoProdutoForm = class(TConsultaPadraoForm)
    CDSConsultaPRODUTO_GRUPO_ID: TIntegerField;
    CDSConsultaATIVO: TSmallintField;
    CDSConsultaDATA_CADASTRO: TSQLTimeStampField;
    CDSConsultaDATA_ULTIMA_ALTERACAO: TSQLTimeStampField;
    CDSConsultaDESCRICAO: TStringField;
    procedure CBCriterioSelect(Sender: TObject);
    procedure EditValorKeyPress(Sender: TObject; var Key: Char);
    procedure BTPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BTAlterarClick(Sender: TObject);
    procedure BTNovoClick(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar;
    procedure CarregaHint;
  public
    { Public declarations }
  end;

var
  ConsultaGrupoProdutoForm: TConsultaGrupoProdutoForm;

implementation
uses Base, UFuncoes, UCadastroGrupoProduto;
{$R *.dfm}

procedure TConsultaGrupoProdutoForm.CarregaHint;
begin
  CBCriterio.Hint := 'Campo a ser pesquisado';
  CBCondicao.Hint := 'Condi??o para pesquisa';
  EditValor.Hint := 'Valor a ser pesquisado';
  CBSituacao.Hint := 'Situa??o do Registro (Ativo/Inativo)';
  DBGrid1.Hint := 'Registro da Pesquisa';
  BTPesquisar.Hint := 'Execure a Pesquisa';
  BTNovo.Hint := 'Insira um novo Grupo de Produtos';
  BTAlterar.Hint := 'Altere o Grupo de Produtos selecionado';
  BTExportar.Hint := 'Exporte os Dados do Grupo de Produtos selecionado';
  BTSair.Hint := 'Sair da Tela de Consulta do Grupo de Produtos';
end;

procedure TConsultaGrupoProdutoForm.Pesquisar;
var
  Criterio, Condicao, Campo, Valor : ShortString;
begin
  try
    CDSConsulta.DisableControls;
    Valor := Trim(UpperCase(EditValor.Text));

    BancoDados.SqlConsulta := 'select * from ' + BancoDados.Tabela;

    if (Valor <> '') then
      begin
        case CBCriterio.ItemIndex of
          1: Campo := 'PRODUTO_GRUPO_ID';
          2: Campo := 'DESCRICAO';
        end;

        case CBCriterio.ItemIndex of
          1: begin
            case CBCondicao.ItemIndex of
              0: Condicao := ' where ' + Campo + ' < '   + Valor;
              1: Condicao := ' where ' + Campo + ' <= '  + Valor;
              2: Condicao := ' where ' + Campo + ' >= '  + Valor;
              3: Condicao := ' where ' + Campo + ' > '   + Valor;
              4: Condicao := ' where ' + Campo + ' = '   + Valor;
              5: Condicao := ' where ' + Campo + ' <> '  + Valor;
            end;
          end;
          2: begin
            case CBCondicao.ItemIndex of
              0: Condicao := ' where Upper(' + Campo + ') = '       + QuotedStr(Valor);
              1: Condicao := ' where Upper(' + Campo + ') <> '      + QuotedStr(Valor);
              2: Condicao := ' where Upper(' + Campo + ') like '    + QuotedStr(Valor + '%');
              3: Condicao := ' where Upper(' + Campo + ') like '    + QuotedStr('%' + Valor + '%');
              4: Condicao := ' where Upper(' + Campo + ') like '    + QuotedStr(Valor + '%');
            end;
          end;
        end;

        BancoDados.SqlConsulta := BancoDados.SqlConsulta + Condicao;
      end;

    if (CBSituacao.ItemIndex in [0,1]) then
      begin
        if (Pos('where', BancoDados.SqlConsulta) > 0) then
          BancoDados.SqlConsulta := BancoDados.SqlConsulta + ' and ATIVO = ' + IntToStr(CBSituacao.ItemIndex)
        else
          BancoDados.SqlConsulta := BancoDados.SqlConsulta + ' where ATIVO = ' + IntToStr(CBSituacao.ItemIndex);
      end;

    CDSConsulta.Close;
    qryConsulta.SQL.Text := BancoDados.SqlConsulta;
    CDSConsulta.Open;

    CDSConsulta.Last;
    CDSConsulta.First;
    SBPrincipal.Panels[0].Text := IntToStr(CDSConsulta.RecordCount) + ' Registro(s) Encontrado(s).';
  finally
    CDSConsulta.EnableControls;
  end;
end;

procedure TConsultaGrupoProdutoForm.BTAlterarClick(Sender: TObject);
begin
  inherited; //Heran?a

  try
    if not Assigned(CadastroGrupoProdutoForm) then
      CadastroGrupoProdutoForm := TCadastroGrupoProdutoForm.Create(Application);
    BancoDados.Operacao := 'Alterar';
    BancoDados.Id := CDSConsultaPRODUTO_GRUPO_ID.Value;
    SBPrincipal.Panels[0].Text := '';
    CadastroGrupoProdutoForm.ShowModal;
  finally
    CDSConsulta.Close;
    CDSConsulta.Open;
    CadastroGrupoProdutoForm.Free;
    CadastroGrupoProdutoForm := nil;
  end;
end;

procedure TConsultaGrupoProdutoForm.BTNovoClick(Sender: TObject);
begin
  try
    BarraStatus := False;
    if not Assigned(CadastroGrupoProdutoForm) then
      CadastroGrupoProdutoForm := TCadastroGrupoProdutoForm.Create(Application);
    BancoDados.Operacao := 'Inserir';
    SBPrincipal.Panels[0].Text := '';
    CadastroGrupoProdutoForm.ShowModal;
  finally
    CDSConsulta.Close;
    CDSConsulta.Open;
    CadastroGrupoProdutoForm.Free;
    CadastroGrupoProdutoForm := nil;
    BarraStatus := True;
  end;
end;

procedure TConsultaGrupoProdutoForm.BTPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TConsultaGrupoProdutoForm.CBCriterioSelect(Sender: TObject);
begin
  case CBCriterio.ItemIndex of
    1: begin
      CBCondicao.Items.Clear;
      CBCondicao.Items.Add('<  (Menor que:)');
      CBCondicao.Items.Add('<= (Menor ou igual:)');
      CBCondicao.Items.Add('>= (Maior ou igual:)');
      CBCondicao.Items.Add('>  (Maior:)');
      CBCondicao.Items.Add('=  (Igual:)');
      CBCondicao.Items.Add('<> (Diferente:)');
      CBCondicao.ItemIndex := 4;
    end;
    2: begin
      CBCondicao.Items.Clear;
      CBCondicao.Items.Add('= (Igual:)');
      CBCondicao.Items.Add('<> (Diferente:)');
      CBCondicao.Items.Add('Iniciado por');
      CBCondicao.Items.Add('Contendo');
      CBCondicao.Items.Add('Terminado por');
      CBCondicao.ItemIndex := 2;
    end;
  end;

  inherited; //Heran?a
end;

procedure TConsultaGrupoProdutoForm.EditValorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
    BTPesquisarClick(Sender);
end;

procedure TConsultaGrupoProdutoForm.FormCreate(Sender: TObject);
begin
  BancoDados.Tabela := 'PRODUTO_GRUPO';
  BancoDados.SqlConsulta := '';

  inherited; //Heran?a
end;

procedure TConsultaGrupoProdutoForm.FormShow(Sender: TObject);
begin
  inherited; //Heran?a

  CBCriterioSelect(Sender);
  BTPesquisarClick(Sender);
  CarregaHint;
end;

end.
