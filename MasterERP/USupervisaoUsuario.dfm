object SupervisaoUsuarioForm: TSupervisaoUsuarioForm
  Left = 0
  Top = 0
  Caption = 'MasterERP - Acesso do Usu'#225'rio'
  ClientHeight = 192
  ClientWidth = 323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 71
    Top = 32
    Width = 44
    Height = 19
    Caption = 'Login'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel
    Left = 68
    Top = 81
    Width = 49
    Height = 19
    Caption = 'Senha'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object EditLogin: TEdit
    Left = 67
    Top = 54
    Width = 178
    Height = 21
    Hint = 'Digite seu Login'
    TabStop = False
    BevelInner = bvNone
    BevelKind = bkFlat
    CharCase = ecUpperCase
    MaxLength = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnKeyPress = EditLoginKeyPress
  end
  object EditSenha: TEdit
    Left = 67
    Top = 102
    Width = 178
    Height = 21
    Hint = 'Digite sua Senha (M'#225'ximo 8 D'#237'ditos)'
    TabStop = False
    BevelKind = bkFlat
    CharCase = ecLowerCase
    MaxLength = 7
    PasswordChar = '*'
    TabOrder = 1
    OnKeyPress = EditSenhaKeyPress
  end
  object Panel1: TPanel
    Left = 0
    Top = 153
    Width = 323
    Height = 39
    Align = alBottom
    TabOrder = 2
    object BTConfirmar: TSpeedButton
      Left = 115
      Top = 5
      Width = 98
      Height = 31
      Caption = 'Confirmar'
      OnClick = BTConfirmarClick
    end
    object BTCancelar: TSpeedButton
      Left = 218
      Top = 5
      Width = 98
      Height = 31
      Caption = 'Cancelar'
      OnClick = BTCancelarClick
    end
  end
end
