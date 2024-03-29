object Form_ConsultaUsuario: TForm_ConsultaUsuario
  Left = 0
  Top = 0
  Caption = 'Consultar Usu'#225'rio'
  ClientHeight = 612
  ClientWidth = 866
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel_relatorioMovimento: TPanel
    Left = 0
    Top = 0
    Width = 866
    Height = 612
    Align = alClient
    UseDockManager = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label_ConsultarUsua: TLabel
      Left = 312
      Top = 24
      Width = 188
      Height = 32
      Caption = 'Consultar Usu'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton_exibirTodos: TSpeedButton
      Left = 187
      Top = 561
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
      Top = 561
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
      Top = 561
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
      object ComboBox_Filtro: TComboBox
        Left = 17
        Top = 64
        Width = 145
        Height = 29
        TabOrder = 0
      end
      inline Frame_Status: TFrame_Generico
        Left = 528
        Top = 15
        Width = 185
        Height = 88
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        ExplicitLeft = 528
        ExplicitTop = 15
        ExplicitWidth = 185
        ExplicitHeight = 88
        inherited Label_Titulo: TLabel
          Top = 23
          ExplicitTop = 23
        end
        inherited ComboBox_Informacao: TComboBox
          Left = 2
          Top = 49
          Width = 167
          ExplicitLeft = 2
          ExplicitTop = 49
          ExplicitWidth = 167
        end
        inherited TableTemp: TFDMemTable
          Left = 72
          Top = 32
        end
      end
      object Bit_Filtrar: TBitBtn
        Left = 719
        Top = 64
        Width = 75
        Height = 29
        Caption = 'Filtrar'
        TabOrder = 2
        OnClick = Bit_FiltrarClick
      end
      object Edit_pesquisa: TEdit
        Left = 193
        Top = 64
        Width = 320
        Height = 29
        MaxLength = 33
        TabOrder = 3
      end
    end
    object GroupBox_Pesquisa: TGroupBox
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
      object resultadoUsuario: TDBGrid
        Left = 17
        Top = 32
        Width = 776
        Height = 281
        DataSource = DataSource_Consulta
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = [fsBold]
        OnDblClick = resultadoUsuarioDblClick
        Columns = <
          item
            Expanded = False
            Width = 61
            Visible = True
          end
          item
            Expanded = False
            Width = 222
            Visible = True
          end
          item
            Expanded = False
            Width = 205
            Visible = True
          end
          item
            Expanded = False
            Width = 162
            Visible = True
          end
          item
            Expanded = False
            Width = 81
            Visible = True
          end>
      end
    end
  end
  object FDMemTable_Usuario: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 155
    Top = 346
  end
  object DataSource_Consulta: TDataSource
    DataSet = FDMemTable_Usuario
    Left = 396
    Top = 330
  end
end
