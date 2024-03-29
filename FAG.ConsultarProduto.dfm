object Form_ConsultarProduto: TForm_ConsultarProduto
  Left = 0
  Top = 0
  Caption = 'Consultar Produtos '
  ClientHeight = 620
  ClientWidth = 853
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel_relatorioMovimento: TPanel
    Left = 0
    Top = 0
    Width = 853
    Height = 620
    Align = alClient
    UseDockManager = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label_ConsultarProd: TLabel
      Left = 312
      Top = 24
      Width = 203
      Height = 32
      Caption = 'Consultar Produtos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton_exibirTodos: TSpeedButton
      Left = 187
      Top = 565
      Width = 132
      Height = 33
      Caption = 'Exibir Todos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton_exibirTodosClick
    end
    object SpeedButton_limparConsulta: TSpeedButton
      Left = 339
      Top = 565
      Width = 132
      Height = 33
      Caption = 'Limpar Consulta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton_limparConsultaClick
    end
    object SpeedButton_Voltar: TSpeedButton
      Left = 491
      Top = 565
      Width = 132
      Height = 33
      Caption = 'Voltar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton_VoltarClick
    end
    object GroupBox1: TGroupBox
      Left = 19
      Top = 74
      Width = 809
      Height = 119
      BiDiMode = bdLeftToRight
      Caption = 'Dados da Consulta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 0
      object Label_produto: TLabel
        Left = 193
        Top = 42
        Width = 44
        Height = 21
        Caption = 'Dados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label_filtro: TLabel
        Left = 17
        Top = 37
        Width = 36
        Height = 21
        Caption = 'Filtro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Edit_produto: TEdit
        Left = 193
        Top = 64
        Width = 321
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
        TabOrder = 1
      end
      object ComboBox_filtro: TComboBox
        Left = 16
        Top = 64
        Width = 153
        Height = 29
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = ComboBox_filtroChange
      end
      inline Frame_categoria: TFrame_Generico
        Left = 520
        Top = 37
        Width = 175
        Height = 59
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        ExplicitLeft = 520
        ExplicitTop = 37
        ExplicitWidth = 175
        ExplicitHeight = 59
        inherited Label_Titulo: TLabel
          Left = 9
          Top = 0
          ExplicitLeft = 9
          ExplicitTop = 0
        end
        inherited ComboBox_Informacao: TComboBox
          Left = 9
          Top = 27
          Width = 163
          Style = csDropDownList
          OnExit = Frame_categoriaComboBox_InformacaoExit
          ExplicitLeft = 9
          ExplicitTop = 27
          ExplicitWidth = 163
        end
      end
      object BitBtn1: TBitBtn
        Left = 714
        Top = 64
        Width = 75
        Height = 29
        Caption = 'Filtrar'
        TabOrder = 3
        OnClick = BitBtn1Click
      end
    end
    object GroupBox2: TGroupBox
      Left = 19
      Top = 199
      Width = 809
      Height = 338
      BiDiMode = bdLeftToRight
      Caption = 'Resultados da Pesquisa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 1
      object Panel_resultadoPesquisa: TPanel
        Left = 16
        Top = 32
        Width = 774
        Height = 289
        Caption = 'Panel_resultadoPesquisa'
        TabOrder = 0
        object DBGrid_resultadoPesquisa: TDBGrid
          Left = 1
          Top = 1
          Width = 772
          Height = 287
          Align = alClient
          Color = clWhite
          DataSource = DataSource_consultaProduto
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = [fsBold]
          OnDblClick = DBGrid_resultadoPesquisaDblClick
          Columns = <
            item
              Expanded = False
              Width = 96
              Visible = True
            end
            item
              Expanded = False
              Width = 172
              Visible = True
            end
            item
              Expanded = False
              Width = 435
              Visible = True
            end>
        end
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 503
    Top = 391
  end
  object FDMemTable_consultaProduto: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 203
    Top = 383
  end
  object DataSource_consultaProduto: TDataSource
    DataSet = FDMemTable_consultaProduto
    Left = 368
    Top = 384
  end
end
