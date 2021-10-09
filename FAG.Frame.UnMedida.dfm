object Frame_UnMedida: TFrame_UnMedida
  Left = 0
  Top = 0
  Width = 245
  Height = 62
  TabOrder = 0
  object Label_Titulo: TLabel
    Left = 0
    Top = -1
    Width = 20
    Height = 21
    Caption = '%s'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object ComboBox_Informacao: TComboBox
    Left = 0
    Top = 26
    Width = 233
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnExit = ComboBox_InformacaoExit
  end
  object TableTemp: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 87
    Top = 8
  end
end
