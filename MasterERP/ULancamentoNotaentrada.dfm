inherited LancamentoNotaEntradaForm: TLancamentoNotaEntradaForm
  Caption = 'LancamentoNotaentradaForm'
  ClientHeight = 618
  ClientWidth = 890
  ExplicitLeft = -94
  ExplicitTop = -109
  ExplicitWidth = 906
  ExplicitHeight = 654
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Height = 599
    ExplicitHeight = 564
    inherited GHPPrincipal: TJvGradientHeaderPanel
      Height = 597
      ExplicitHeight = 562
    end
  end
  inherited SBPrincipal: TStatusBar
    Top = 599
    Width = 890
    ExplicitTop = 564
    ExplicitWidth = 890
  end
  inherited PPrincipal: TPanel
    Width = 733
    Height = 599
    ExplicitWidth = 733
    ExplicitHeight = 564
    object Label1: TLabel
      Left = 52
      Top = 166
      Width = 59
      Height = 13
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object LBFornecedorNome: TLabel
      Left = 227
      Top = 166
      Width = 241
      Height = 13
      AutoSize = False
      Caption = 'Fornecedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6590965
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 32
      Top = 193
      Width = 79
      Height = 13
      Alignment = taRightJustify
      Caption = 'Transportadora:'
    end
    object LBTransportadoraNome: TLabel
      Left = 227
      Top = 193
      Width = 241
      Height = 13
      AutoSize = False
      Caption = 'Transportadora'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6590965
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 8
      Top = 221
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'Produto I.D'
    end
    object Label7: TLabel
      Left = 93
      Top = 221
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o'
    end
    object Label8: TLabel
      Left = 472
      Top = 221
      Width = 22
      Height = 13
      Alignment = taRightJustify
      Caption = 'Qtd.'
    end
    object Label9: TLabel
      Left = 551
      Top = 221
      Width = 68
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valor Unit'#225'rio:'
    end
    object Label10: TLabel
      Left = 630
      Top = 221
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'Total:'
    end
    object Label11: TLabel
      Left = 6
      Top = 547
      Width = 115
      Height = 13
      Alignment = taRightJustify
      Caption = '(+) Valor do Frete (R$):'
    end
    object DBTextValorProduto: TDBText
      Left = 594
      Top = 511
      Width = 130
      Height = 25
      DataField = 'VALOR_NOTA'
      DataSource = DSCadastro
      Font.Charset = ANSI_CHARSET
      Font.Color = 6590965
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 594
      Top = 498
      Width = 118
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valor dos Produtos (R$):'
    end
    object Label13: TLabel
      Left = 594
      Top = 550
      Width = 93
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valor da Nota (R$):'
    end
    object DBTextValorNota: TDBText
      Left = 594
      Top = 564
      Width = 130
      Height = 25
      DataField = 'VALOR_NOTA'
      DataSource = DSCadastro
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 376
      Top = 221
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label15: TLabel
      Left = 55
      Top = 139
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nota Fiscal:'
    end
    object Label16: TLabel
      Left = 28
      Top = 114
      Width = 83
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nota Entrada I.D:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EditFornecedor: TJvValidateEdit
      Left = 128
      Top = 163
      Width = 94
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      TabOrder = 1
      ZeroEmpty = True
      OnExit = EditFornecedorExit
      OnKeyDown = EditFornecedorKeyDown
    end
    object EditTransportadora: TJvValidateEdit
      Left = 128
      Top = 190
      Width = 94
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      TabOrder = 2
      ZeroEmpty = True
      OnExit = EditTransportadoraExit
      OnKeyDown = EditTransportadoraKeyDown
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 731
      Height = 103
      Align = alTop
      TabOrder = 4
      object Label4: TLabel
        Left = 39
        Top = 37
        Width = 71
        Height = 13
        Caption = 'Data Cadastro:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBTextDataCadastro: TDBText
        Left = 127
        Top = 37
        Width = 210
        Height = 17
        Hint = 'Data/Hora em que foi efetuado o Cadastro'
        DataField = 'DATA_CADASTRO'
        DataSource = DSCadastro
        Font.Charset = ANSI_CHARSET
        Font.Color = 6590965
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 30
        Top = 58
        Width = 80
        Height = 13
        Caption = #218'ltima Altera'#231#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBTextUltimaAlteracao: TDBText
        Left = 127
        Top = 58
        Width = 210
        Height = 17
        Hint = 'Data da '#250'ltima Altera'#231#227'o efetuada no Registro'
        DataField = 'DATA_ULTIMA_ALTERACAO'
        DataSource = DSCadastro
        Font.Charset = ANSI_CHARSET
        Font.Color = 6590965
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 44
        Top = 78
        Width = 66
        Height = 13
        Caption = 'Data Entrada:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBCCancelado: TDBCheckBox
        Left = 127
        Top = 14
        Width = 65
        Height = 17
        TabStop = False
        Caption = 'Cancelado'
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
      object DBCFinalizado: TDBCheckBox
        Left = 231
        Top = 14
        Width = 65
        Height = 17
        TabStop = False
        Caption = 'Finalizado'
        TabOrder = 1
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
      object EditaDataEntrada: TJvDBDateEdit
        Left = 127
        Top = 75
        Width = 121
        Height = 21
        TabStop = False
        DataField = 'DATA_ENTRADA'
        DataSource = DSCadastro
        TabOrder = 2
      end
    end
    object DBGrid1: TDBGrid
      Left = 8
      Top = 264
      Width = 716
      Height = 227
      DataSource = DSNotaEntradaItem
      FixedColor = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      PopupMenu = PopupMenu1
      ReadOnly = True
      TabOrder = 5
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'FORNECEDOR_ID'
          Title.Caption = 'Fornecedor I.D'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'calc_fornecedor_nome'
          Title.Caption = 'Nome / Raz'#227'o Social'
          Width = 370
          Visible = True
        end>
    end
    object EditProduto: TJvValidateEdit
      Left = 8
      Top = 237
      Width = 81
      Height = 21
      TabStop = False
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      TabOrder = 3
      OnExit = EditProdutoExit
      OnKeyDown = EditProdutoKeyDown
    end
    object EditDescricao: TEdit
      Left = 93
      Top = 237
      Width = 278
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 6
    end
    object EditQuantidade: TJvValidateEdit
      Left = 472
      Top = 237
      Width = 75
      Height = 21
      TabStop = False
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfFloat
      DecimalPlaces = 2
      TabOrder = 7
      OnKeyDown = EditQuantidadeKeyDown
    end
    object EditValorUnitario: TJvValidateEdit
      Left = 551
      Top = 237
      Width = 75
      Height = 21
      TabStop = False
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfFloat
      DecimalPlaces = 2
      TabOrder = 8
      OnExit = EditValorUnitarioExit
      OnKeyDown = EditValorUnitarioKeyDown
    end
    object EditTotal: TJvValidateEdit
      Left = 630
      Top = 237
      Width = 94
      Height = 21
      TabStop = False
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfFloat
      DecimalPlaces = 2
      ReadOnly = True
      TabOrder = 9
    end
    object DBEditFrete: TDBEdit
      Left = 6
      Top = 564
      Width = 155
      Height = 28
      TabStop = False
      DataField = 'VALOR_FRETE'
      DataSource = DSCadastro
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnExit = DBEditFreteExit
    end
    object CBUnidade: TComboBox
      Left = 376
      Top = 237
      Width = 91
      Height = 21
      TabOrder = 11
      TabStop = False
      Text = 'CBUnidade'
      OnKeyDown = CBUnidadeKeyDown
    end
    object EditNotaFiscal: TJvValidateEdit
      Left = 128
      Top = 136
      Width = 94
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      TabOrder = 0
      ZeroEmpty = True
      OnExit = EditNotaFiscalExit
      OnKeyDown = EditNotaFiscalKeyDown
    end
    object DBEditCodigo: TDBEdit
      Left = 128
      Top = 111
      Width = 94
      Height = 21
      TabStop = False
      Color = clScrollBar
      DataField = 'NOTA_ENTRADA_ID'
      DataSource = DSCadastro
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 12
    end
  end
  inherited qryCadastro: TSQLQuery
    SQL.Strings = (
      'select * from nota_entrada where nota_entrada_id = 0')
  end
  inherited CDSCadastro: TClientDataSet
    object CDSCadastroNOTA_ENTRADA_ID: TIntegerField
      FieldName = 'NOTA_ENTRADA_ID'
      DisplayFormat = '0000000000'
    end
    object CDSCadastroEMPRESA_ID: TIntegerField
      FieldName = 'EMPRESA_ID'
    end
    object CDSCadastroFORNECEDOR_ID: TIntegerField
      FieldName = 'FORNECEDOR_ID'
      DisplayFormat = '0000000000'
    end
    object CDSCadastroDATA_CADASTRO: TSQLTimeStampField
      FieldName = 'DATA_CADASTRO'
    end
    object CDSCadastroDATA_ULTIMA_ALTERACAO: TSQLTimeStampField
      FieldName = 'DATA_ULTIMA_ALTERACAO'
    end
    object CDSCadastroDATA_ENTRADA: TSQLTimeStampField
      FieldName = 'DATA_ENTRADA'
    end
    object CDSCadastroTRANSPORTADORA_ID: TIntegerField
      FieldName = 'TRANSPORTADORA_ID'
      DisplayFormat = '0000000000'
    end
    object CDSCadastroCANCELADO: TSmallintField
      FieldName = 'CANCELADO'
    end
    object CDSCadastroVALOR_FRETE: TFloatField
      FieldName = 'VALOR_FRETE'
      DisplayFormat = ',0.00'
    end
    object CDSCadastroVALOR_PRODUTOS: TFloatField
      FieldName = 'VALOR_PRODUTOS'
      DisplayFormat = ',0.00'
    end
    object CDSCadastroVALOR_NOTA: TFloatField
      FieldName = 'VALOR_NOTA'
      DisplayFormat = ',0.00'
    end
    object CDSCadastroFINALIZADO: TSmallintField
      FieldName = 'FINALIZADO'
    end
    object CDSCadastroNOTA_FISCAL: TIntegerField
      FieldName = 'NOTA_FISCAL'
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 786
    Top = 0
  end
  object DSNotaEntradaItem: TDataSource
    DataSet = CDSNotaEntradaItem
    Left = 472
    Top = 400
  end
  object CDSNotaEntradaItem: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSPNotaEntradaItem'
    OnCalcFields = CDSNotaEntradaItemCalcFields
    Left = 472
    Top = 354
    object CDSNotaEntradaItemNOTA_ENTRADA_ITEM_ID: TIntegerField
      FieldName = 'NOTA_ENTRADA_ITEM_ID'
    end
    object CDSNotaEntradaItemNOTA_ENTRADA_ID: TIntegerField
      FieldName = 'NOTA_ENTRADA_ID'
    end
    object CDSNotaEntradaItemPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
      DisplayFormat = '0000000000'
    end
    object CDSNotaEntradaItemVALOR_UNITARIO: TFloatField
      FieldName = 'VALOR_UNITARIO'
      DisplayFormat = ',0.00'
    end
    object CDSNotaEntradaItemQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
      DisplayFormat = ',0.00'
    end
    object CDSNotaEntradaItemcalc_total: TFloatField
      FieldKind = fkCalculated
      FieldName = 'calc_total'
      Calculated = True
    end
    object CDSNotaEntradaItemUNIDADE_ID: TIntegerField
      FieldName = 'UNIDADE_ID'
    end
    object CDSNotaEntradaItemcalc_unidade_descricao: TStringField
      FieldKind = fkCalculated
      FieldName = 'calc_unidade_descricao'
      Calculated = True
    end
  end
  object DSPNotaEntradaItem: TDataSetProvider
    DataSet = qryNotaEntradaItem
    Options = [poAutoRefresh, poUseQuoteChar]
    Left = 472
    Top = 308
  end
  object qryNotaEntradaItem: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from nota_entrada_item where nota_entrada_item_id = 0')
    SQLConnection = BancoDados.Conexao
    Left = 472
    Top = 264
  end
  object PopupMenu1: TPopupMenu
    Left = 787
    Top = 45
    object ExcluirItem1: TMenuItem
      Caption = 'Excluir Item'
      OnClick = ExcluirItem1Click
    end
  end
end
