unit UPesquisaTransportadora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UPesquisaPadrao, FMTBcd, ActnList, Menus, AppEvnts, DB, DBClient,
  Provider, SqlExpr, Grids, DBGrids, StdCtrls, JvExControls,
  JvGradientHeaderPanel, ExtCtrls, ComCtrls;

type
  TPesquisaTransportadoraForm = class(TPesquisaPadraoForm)
    CDSConsultaPESSOA_ID: TIntegerField;
    CDSConsultaATIVO: TSmallintField;
    CDSConsultaDATA_CADASTRO: TSQLTimeStampField;
    CDSConsultaDATA_ULTIMA_ALTERACAO: TSQLTimeStampField;
    CDSConsultaNOME_RAZAO: TStringField;
    CDSConsultaNOME_APELIDO_FANTASIA: TStringField;
    CDSConsultaTRANSPORTADORA_ID: TIntegerField;
    CDSConsultaCNPJ_CPF: TStringField;
    CDSConsultaTIPO: TStringField;
    CDSConsultaIE_IDENTIDADE: TStringField;
    CDSConsultaIM: TStringField;
    CDSConsultaEMPRESA_ID: TIntegerField;
    CDSConsultacalc_tipo: TStringField;
    CDSConsultacalc_filial: TSmallintField;
    procedure CDSConsultaCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure CBCriterioSelect(Sender: TObject);
    procedure EditValorChange(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar;
  public
    { Public declarations }
  end;

var
  PesquisaTransportadoraForm: TPesquisaTransportadoraForm;

implementation
uses Base;
{$R *.dfm}

procedure TPesquisaTransportadoraForm.Pesquisar;
var
  Criterio, Condicao, Campo, Valor : ShortString;
  SqlConsulta : String;
begin
  try
    CDSConsulta.DisableControls;
    Valor := Trim(UpperCase(EditValor.Text));
    SqlConsulta := 'select p.PESSOA_ID, t.ATIVO, t.DATA_CADASTRO, ' +
      't.DATA_ULTIMA_ALTERACAO, p.NOME_RAZAO, p.NOME_APELIDO_FANTASIA, t.TRANSPORTADORA_ID, ' +
      't.CNPJ_CPF, t.TIPO, t.IE_IDENTIDADE, t.IM, t.FILIAL ' +
      'from PESSOA p, TRANSPORTADORA t where (t.PESSOA_ID = p.PESSOA_ID)';

    if (Valor <> '') then
      begin
        case CBCriterio.ItemIndex of
          1: Campo := 't.TRANSPORTADORA_ID';
          2: Campo := 'p.NOME_RAZAO';
          3: Campo := 'p.NOME_APELIDO_FANTASIA';
        end;

        case CBCriterio.ItemIndex of
          1: begin
            case CBCondicao.ItemIndex of
              0: Condicao := ' and ' + Campo + ' < '   + Valor;
              1: Condicao := ' and ' + Campo + ' <= '  + Valor;
              2: Condicao := ' and ' + Campo + ' >= '  + Valor;
              3: Condicao := ' and ' + Campo + ' > '   + Valor;
              4: Condicao := ' and ' + Campo + ' = '   + Valor;
              5: Condicao := ' and ' + Campo + ' <> '  + Valor;
            end;
          end;
          2,3: begin
            case CBCondicao.ItemIndex of
              0: Condicao := ' and Upper(' + Campo + ') = '       + QuotedStr(Valor);
              1: Condicao := ' and Upper(' + Campo + ') <> '      + QuotedStr(Valor);
              2: Condicao := ' and Upper(' + Campo + ') like '    + QuotedStr(Valor + '%');
              3: Condicao := ' and Upper(' + Campo + ') like '    + QuotedStr('%' + Valor + '%');
              4: Condicao := ' and Upper(' + Campo + ') like '    + QuotedStr(Valor + '%');
            end;
          end;
        end;

        SqlConsulta := SqlConsulta + Condicao;
      end;

    if (CBSituacao.ItemIndex in [0,1]) then
      begin
        if (Pos('where', SqlConsulta) > 0) then
          SqlConsulta := SqlConsulta + ' and t.ATIVO = ' + IntToStr(CBSituacao.ItemIndex)
        else
          SqlConsulta := SqlConsulta + ' where t.ATIVO = ' + IntToStr(CBSituacao.ItemIndex);
      end;

    CDSConsulta.Close;
    qryConsulta.SQL.Text := SqlConsulta;
    CDSConsulta.Open;

    CDSConsulta.Last;
    CDSConsulta.First;
    SBPrincipal.Panels[0].Text := IntToStr(CDSConsulta.RecordCount) + ' Registro(s) Encontrado(s).';
  finally
    CDSConsulta.EnableControls;
  end;
end;

procedure TPesquisaTransportadoraForm.CBCriterioSelect(Sender: TObject);
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
    2,3: begin
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

procedure TPesquisaTransportadoraForm.CDSConsultaCalcFields(DataSet: TDataSet);
begin
  if (CDSConsultaTIPO.Value = 'J') then
    CDSConsultacalc_tipo.Value := 'Pessoa Jur?dica'
  else if (CDSConsultaTIPO.Value = 'F') then
    CDSConsultacalc_tipo.Value := 'Pessoa F?sica';

  with BancoDados.qryAuxiliar do
    begin
      Close;
      SQL.Text := 'select filial where empresa where empresa_id = ' +
        IntToStr(CDSConsultaEMPRESA_ID.Value);
      Open;
    end;
  if not (BancoDados.qryAuxiliar.IsEmpty) then
    CDSConsultacalc_filial.Value := BancoDados.qryAuxiliar.Fields[0].Value;
end;

procedure TPesquisaTransportadoraForm.EditValorChange(Sender: TObject);
begin
  Pesquisar;
end;

procedure TPesquisaTransportadoraForm.FormCreate(Sender: TObject);
begin
  Tabela := 'TRANSPORTADORA';
  CampoID := 'transportadora_id';
  CampoNome := 'Nome_Razao';
end;

end.
