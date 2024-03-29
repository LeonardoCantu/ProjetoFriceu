object Form_CadastroProduto: TForm_CadastroProduto
  Left = 380
  Top = 5
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Cadastrar Produto'
  ClientHeight = 471
  ClientWidth = 869
  Color = clBtnFace
  Constraints.MaxHeight = 500
  Constraints.MaxWidth = 875
  Constraints.MinHeight = 500
  Constraints.MinWidth = 875
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  PopupMode = pmExplicit
  Position = poDesigned
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 21
  object Panel_cadastroProduto: TPanel
    Left = 0
    Top = 0
    Width = 869
    Height = 471
    Align = alClient
    UseDockManager = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label_tituloForm: TLabel
      Left = 313
      Top = 40
      Width = 191
      Height = 32
      Caption = 'Cadastrar Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object GroupBox1: TGroupBox
      Left = 27
      Top = 130
      Width = 814
      Height = 199
      BiDiMode = bdLeftToRight
      Caption = 'Dados B'#225'sicos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        814
        199)
      object Label_codigo: TLabel
        Left = 16
        Top = 27
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
      object Label_status: TLabel
        Left = 104
        Top = 27
        Width = 59
        Height = 21
        Caption = 'Situa'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label_data: TLabel
        Left = 611
        Top = 27
        Width = 32
        Height = 21
        Caption = 'Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label_descricao: TLabel
        Left = 224
        Top = 27
        Width = 67
        Height = 21
        Caption = 'Descri'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label_valor: TLabel
        Left = 504
        Top = 98
        Width = 40
        Height = 21
        Caption = 'Custo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Edit_codigo: TEdit
        Left = 16
        Top = 51
        Width = 70
        Height = 29
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
      end
      object ComboBox_status: TComboBox
        Left = 104
        Top = 51
        Width = 105
        Height = 29
        TabOrder = 2
      end
      object Edit_descricao: TEdit
        Left = 224
        Top = 51
        Width = 361
        Height = 29
        AutoSize = False
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 33
        ParentFont = False
        TabOrder = 3
      end
      object DateTimePicker1: TDateTimePicker
        Left = 611
        Top = 51
        Width = 185
        Height = 29
        Date = 44112.000000000000000000
        Time = 0.354362268517434100
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      inline Frame_Categoria: TFrame_Generico
        Left = 16
        Top = 102
        Width = 191
        Height = 60
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnExit = Frame_CategoriaExit
        ExplicitLeft = 16
        ExplicitTop = 102
        ExplicitWidth = 191
        inherited ComboBox_Informacao: TComboBox
          Width = 190
          Style = csDropDownList
          OnExit = Frame_CategoriaComboBox_InformacaoExit
          ExplicitWidth = 190
        end
        inherited TableTemp: TFDMemTable
          Left = 120
        end
      end
      object Edit_valor: TEdit
        Left = 504
        Top = 125
        Width = 102
        Height = 29
        BiDiMode = bdRightToLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 11
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 7
        OnChange = Edit_valorChange
        OnKeyPress = Edit_valorKeyPress
      end
      inline Frame_UnMedida: TFrame_Generico
        Left = 259
        Top = 102
        Width = 193
        Height = 60
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        ExplicitLeft = 259
        ExplicitTop = 102
        ExplicitWidth = 193
        inherited ComboBox_Informacao: TComboBox
          Width = 185
          Style = csDropDownList
          OnExit = Frame_UnMedidaComboBox_InformacaoExit
          ExplicitWidth = 185
        end
        inherited TableTemp: TFDMemTable
          Left = 104
        end
      end
      object BitBtn_categoria: TBitBtn
        Left = 212
        Top = 128
        Width = 26
        Height = 25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'TeamViewer15'
        Font.Style = [fsBold]
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFF5F5F5DADADACCCCCCCCCCCCCCCCCCCCCCCCDADADAF5F5F5FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDDDDDA3C0B3369D6E008C4B00
          8B4A008B4A008C4B369D6EA3C0B3E1E1E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          E1E1E144A27700905001A16900AA7600AB7700AB7700AA7601A16900905055A8
          82E1E1E1FFFFFFFFFFFFFFFFFFF5F5F555A88200915202AC7700C38C00D69918
          DEA818DEA800D69900C38C01AB7600925355A882F5F5F5FFFFFFFFFFFFAECABE
          0090510FB48302D29900D69B00D193FFFFFFFFFFFF00D19300D69B00D19801AB
          76009050AECBBEFFFFFFFFFFFF369D6C16AB7811C99700D49A00D29700CD8EFF
          FFFFFFFFFF00CD8E00D29700D59B00C18C01A169369E6EFFFFFFFFFFFF008A48
          38C49C00D19800CD9200CB8E00C787FFFFFFFFFFFF00C78700CB8E00CE9300D0
          9A00AB76008C4BFFFFFFFFFFFF00894651D2AF12D4A3FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF00CF9700AD78008B4AFFFFFFFFFFFF008845
          66DDBE10D0A2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00CD
          9700AD78008B4AFFFFFFFFFFFF00884676E0C500CA9800C59000C48E00C187FF
          FFFFFFFFFF00C18700C48E00C79300CB9900AB76008C4BFFFFFFFFFFFF41A675
          59C9A449DEBC00C79400C79400C38EFFFFFFFFFFFF00C38E00C89600CB9A06C1
          9000A16840A878FFFFFFFFFFFFCCE8DB0A9458ADF8E918D0A700C49400C290FF
          FFFFFFFFFF00C39100C79905C89B18B787009050CCE8DBFFFFFFFFFFFFFFFFFF
          55B185199C63BCFFF75DE4C900C39700BF9000C09100C49822CAA231C2970393
          556ABC96FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6ABB940E965974D5B69FF3E092
          EFDA79E5CA5DD6B52EB58603915255B288FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFCCE8DB44A87700874400874300874400894644AA7ACCE8DBFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = BitBtn_categoriaClick
      end
      object BitBtn_unMedida: TBitBtn
        Left = 451
        Top = 128
        Width = 26
        Height = 25
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFF5F5F5DADADACCCCCCCCCCCCCCCCCCCCCCCCDADADAF5F5F5FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDDDDDA3C0B3369D6E008C4B00
          8B4A008B4A008C4B369D6EA3C0B3E1E1E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          E1E1E144A27700905001A16900AA7600AB7700AB7700AA7601A16900905055A8
          82E1E1E1FFFFFFFFFFFFFFFFFFF5F5F555A88200915202AC7700C38C00D69918
          DEA818DEA800D69900C38C01AB7600925355A882F5F5F5FFFFFFFFFFFFAECABE
          0090510FB48302D29900D69B00D193FFFFFFFFFFFF00D19300D69B00D19801AB
          76009050AECBBEFFFFFFFFFFFF369D6C16AB7811C99700D49A00D29700CD8EFF
          FFFFFFFFFF00CD8E00D29700D59B00C18C01A169369E6EFFFFFFFFFFFF008A48
          38C49C00D19800CD9200CB8E00C787FFFFFFFFFFFF00C78700CB8E00CE9300D0
          9A00AB76008C4BFFFFFFFFFFFF00894651D2AF12D4A3FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF00CF9700AD78008B4AFFFFFFFFFFFF008845
          66DDBE10D0A2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00CD
          9700AD78008B4AFFFFFFFFFFFF00884676E0C500CA9800C59000C48E00C187FF
          FFFFFFFFFF00C18700C48E00C79300CB9900AB76008C4BFFFFFFFFFFFF41A675
          59C9A449DEBC00C79400C79400C38EFFFFFFFFFFFF00C38E00C89600CB9A06C1
          9000A16840A878FFFFFFFFFFFFCCE8DB0A9458ADF8E918D0A700C49400C290FF
          FFFFFFFFFF00C39100C79905C89B18B787009050CCE8DBFFFFFFFFFFFFFFFFFF
          55B185199C63BCFFF75DE4C900C39700BF9000C09100C49822CAA231C2970393
          556ABC96FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6ABB940E965974D5B69FF3E092
          EFDA79E5CA5DD6B52EB58603915255B288FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFCCE8DB44A87700874400874300874400894644AA7ACCE8DBFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        TabOrder = 0
        TabStop = False
        OnClick = BitBtn_unMedidaClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 27
      Top = 352
      Width = 814
      Height = 97
      TabOrder = 1
      object SpeedButton_cancelar: TSpeedButton
        Left = 272
        Top = 32
        Width = 109
        Height = 33
        Caption = 'Cancelar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SpeedButton_cancelarClick
      end
      object SpeedButton_pesquisar: TSpeedButton
        Left = 403
        Top = 32
        Width = 109
        Height = 33
        Caption = 'Pesquisar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SpeedButton_pesquisarClick
      end
      object SpeedButton_sair: TSpeedButton
        Left = 534
        Top = 32
        Width = 109
        Height = 33
        Caption = 'Sair'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SpeedButton_sairClick
      end
      object BitBtn1: TBitBtn
        Left = 144
        Top = 32
        Width = 109
        Height = 33
        Caption = 'Salvar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = BitBtn1Click
      end
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
    Left = 736
    Top = 32
  end
end
