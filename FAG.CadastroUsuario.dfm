object Form_CadastroUsuario: TForm_CadastroUsuario
  Left = 380
  Top = 5
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Cadastrar Usu'#225'rio'
  ClientHeight = 667
  ClientWidth = 884
  Color = clBtnFace
  Constraints.MaxHeight = 696
  Constraints.MaxWidth = 890
  Constraints.MinHeight = 696
  Constraints.MinWidth = 890
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDesigned
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel_CadastroUsuario: TPanel
    Left = 0
    Top = 0
    Width = 884
    Height = 667
    Align = alClient
    UseDockManager = False
    TabOrder = 0
    object Label_tituloForm: TLabel
      Left = 331
      Top = 24
      Width = 186
      Height = 32
      Caption = 'Cadastrar Usu'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton_editar: TSpeedButton
      Left = 476
      Top = 613
      Width = 109
      Height = 33
      Caption = 'Pesquisar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton_editarClick
    end
    object SpeedButton_Sair: TSpeedButton
      Left = 615
      Top = 613
      Width = 109
      Height = 33
      Caption = 'Sair'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton_SairClick
    end
    object GroupBox1: TGroupBox
      Left = 20
      Top = 78
      Width = 821
      Height = 203
      Caption = '  Dados Pessoais  '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label_codigo: TLabel
        Left = 16
        Top = 21
        Width = 50
        Height = 21
        Caption = 'C'#243'digo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label_NomeCompleto: TLabel
        Left = 16
        Top = 82
        Width = 126
        Height = 21
        Caption = 'Nome Completo *'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label_CPF: TLabel
        Left = 371
        Top = 82
        Width = 38
        Height = 21
        Caption = 'CPF *'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label_RG: TLabel
        Left = 531
        Top = 82
        Width = 21
        Height = 21
        Caption = 'RG'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label_nascimento: TLabel
        Left = 136
        Top = 139
        Width = 106
        Height = 21
        Caption = 'Dt. Nascimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label_Matricula: TLabel
        Left = 691
        Top = 82
        Width = 65
        Height = 21
        Caption = 'Matr'#237'cula'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label_Sexo: TLabel
        Left = 16
        Top = 139
        Width = 51
        Height = 21
        Caption = 'G'#234'nero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label_Celular: TLabel
        Left = 252
        Top = 139
        Width = 49
        Height = 21
        Caption = 'Celular'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label_Telefone: TLabel
        Left = 403
        Top = 139
        Width = 57
        Height = 21
        Caption = 'Telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Edit_codigo: TEdit
        Left = 16
        Top = 48
        Width = 65
        Height = 29
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 0
      end
      object Edit_nomecompleto: TEdit
        Left = 16
        Top = 104
        Width = 349
        Height = 29
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 33
        ParentFont = False
        TabOrder = 3
        OnKeyPress = Edit_nomecompletoKeyPress
      end
      object Date_Nascimento: TDateTimePicker
        Left = 136
        Top = 161
        Width = 110
        Height = 29
        Date = 44126.000000000000000000
        Time = 44126.000000000000000000
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxDate = 44169.999988425920000000
        ParentFont = False
        TabOrder = 8
      end
      object Edit_Matricula: TEdit
        Left = 691
        Top = 104
        Width = 93
        Height = 29
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        TabOrder = 6
      end
      inline Frame_Pessoa: TFrame_Generico
        Left = 226
        Top = 21
        Width = 177
        Height = 56
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        ExplicitLeft = 226
        ExplicitTop = 21
        ExplicitWidth = 177
        ExplicitHeight = 56
        inherited Label_Titulo: TLabel
          Left = 5
          Top = 0
          ExplicitLeft = 5
          ExplicitTop = 0
        end
        inherited ComboBox_Informacao: TComboBox
          Left = 4
          Top = 27
          Width = 140
          Style = csDropDownList
          OnChange = Frame_PessoaComboBox_InformacaoChange
          OnExit = Frame_PessoaComboBox_InformacaoExit
          ExplicitLeft = 4
          ExplicitTop = 27
          ExplicitWidth = 140
        end
        inherited TableTemp: TFDMemTable
          Left = 192
          Top = 8
        end
      end
      object Mask_CPF: TMaskEdit
        Left = 371
        Top = 104
        Width = 152
        Height = 29
        CharCase = ecUpperCase
        EditMask = '999.999.999-99;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 14
        ParentFont = False
        TabOrder = 4
        Text = '   .   .   -  '
      end
      inline Frame_Status: TFrame_Generico
        Left = 97
        Top = 22
        Width = 119
        Height = 55
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        ExplicitLeft = 97
        ExplicitTop = 22
        ExplicitWidth = 119
        ExplicitHeight = 55
        inherited Label_Titulo: TLabel
          Left = 4
          ExplicitLeft = 4
        end
        inherited ComboBox_Informacao: TComboBox
          Left = 5
          Top = 26
          Width = 104
          Style = csDropDownList
          OnExit = Frame_StatusComboBox_InformacaoExit
          ExplicitLeft = 5
          ExplicitTop = 26
          ExplicitWidth = 104
        end
        inherited TableTemp: TFDMemTable
          Left = 32
          Top = 8
        end
      end
      object Combo_Genero: TComboBox
        Left = 16
        Top = 161
        Width = 114
        Height = 29
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object Mask_RG: TMaskEdit
        Left = 531
        Top = 104
        Width = 154
        Height = 29
        EditMask = '99.999.999-9;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 12
        ParentFont = False
        TabOrder = 5
        Text = '  .   .   - '
        OnEnter = Mask_cepEnter
        OnExit = Mask_cepExit
      end
      object Mask_Celular: TMaskEdit
        Left = 252
        Top = 161
        Width = 145
        Height = 29
        EditMask = '(99) 9 9999-9999;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 16
        ParentFont = False
        TabOrder = 9
        Text = '(  )       -    '
      end
      object Mask_telefone: TMaskEdit
        Left = 403
        Top = 161
        Width = 145
        Height = 29
        EditMask = '(99) 9999-9999;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 14
        ParentFont = False
        TabOrder = 10
        Text = '(  )     -    '
      end
    end
    object GroupBox2: TGroupBox
      Left = 20
      Top = 291
      Width = 821
      Height = 146
      Caption = '  Endere'#231'o  '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label1: TLabel
        Left = 16
        Top = 19
        Width = 27
        Height = 21
        Caption = 'CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 16
        Top = 80
        Width = 42
        Height = 21
        Caption = 'Bairro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 585
        Top = 19
        Width = 19
        Height = 21
        Caption = 'N'#186
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 667
        Top = 19
        Width = 99
        Height = 21
        Caption = 'Complemento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 496
        Top = 80
        Width = 82
        Height = 21
        Caption = 'Caixa Postal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 217
        Top = 80
        Width = 48
        Height = 21
        Caption = 'Cidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 128
        Top = 19
        Width = 82
        Height = 21
        Caption = 'Logradouro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object UF: TLabel
        Left = 425
        Top = 80
        Width = 46
        Height = 21
        Caption = 'Estado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Edit_bairro: TEdit
        Left = 16
        Top = 103
        Width = 195
        Height = 29
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 21
        ParentFont = False
        TabOrder = 4
        OnKeyPress = Edit_bairroKeyPress
      end
      object Edit_numero: TEdit
        Left = 585
        Top = 41
        Width = 76
        Height = 29
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 7
        ParentFont = False
        TabOrder = 2
      end
      object Edit_complemento: TEdit
        Left = 667
        Top = 41
        Width = 138
        Height = 29
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        TabOrder = 3
      end
      object Edit_cxpostal: TEdit
        Left = 496
        Top = 103
        Width = 138
        Height = 29
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 7
        OnKeyPress = Edit_cxpostalKeyPress
      end
      object Edit_cidade: TEdit
        Left = 217
        Top = 103
        Width = 202
        Height = 29
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 21
        ParentFont = False
        TabOrder = 5
        OnKeyPress = Edit_cidadeKeyPress
      end
      object Edit_logradouro: TEdit
        Left = 128
        Top = 41
        Width = 451
        Height = 29
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 33
        ParentFont = False
        TabOrder = 1
        OnKeyPress = Edit_logradouroKeyPress
      end
      object Mask_cep: TMaskEdit
        Left = 16
        Top = 41
        Width = 105
        Height = 29
        CharCase = ecUpperCase
        EditMask = '99.999-999;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
        Text = '  .   -   '
        OnEnter = Mask_cepEnter
        OnExit = Mask_cepExit
      end
      object Edit_Uf: TEdit
        Left = 425
        Top = 103
        Width = 65
        Height = 29
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 2
        ParentFont = False
        TabOrder = 6
        OnKeyPress = Edit_UfKeyPress
      end
    end
    object GroupBox3: TGroupBox
      Left = 20
      Top = 450
      Width = 821
      Height = 146
      Caption = '  Dados de Acesso '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Label7: TLabel
        Left = 16
        Top = 77
        Width = 43
        Height = 21
        Caption = 'Senha'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 188
        Top = 16
        Width = 43
        Height = 20
        Caption = 'E-mail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 188
        Top = 77
        Width = 118
        Height = 21
        Caption = 'Confirmar Senha'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 16
        Top = 20
        Width = 39
        Height = 21
        Caption = 'Login'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Edit_senha: TEdit
        Left = 16
        Top = 101
        Width = 166
        Height = 29
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 18
        ParentFont = False
        TabOrder = 2
      end
      object Edit_email: TEdit
        Left = 188
        Top = 42
        Width = 270
        Height = 29
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 44
        ParentFont = False
        TabOrder = 1
      end
      object Edit_confirmasenha: TEdit
        Left = 188
        Top = 101
        Width = 156
        Height = 29
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 18
        ParentFont = False
        TabOrder = 3
      end
      object Edit_login: TEdit
        Left = 16
        Top = 42
        Width = 166
        Height = 29
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        TabOrder = 0
        OnKeyPress = Edit_loginKeyPress
      end
    end
    object BitBtn1: TBitBtn
      Left = 193
      Top = 613
      Width = 109
      Height = 33
      Caption = 'Salvar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = BitBtn1Click
    end
    object Cancelar: TBitBtn
      Left = 336
      Top = 613
      Width = 109
      Height = 33
      Caption = 'Cancelar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = CancelarClick
    end
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 240
    Top = 8
  end
  object FDQuery1: TFDQuery
    Left = 620
    Top = 78
  end
  object ACBrCEP1: TACBrCEP
    ProxyPort = '8080'
    ParseText = True
    WebService = wsViaCep
    PesquisarIBGE = True
    Left = 176
    Top = 8
  end
  object validador: TACBrValidador
    IgnorarChar = './-'
    Left = 112
    Top = 8
  end
end
