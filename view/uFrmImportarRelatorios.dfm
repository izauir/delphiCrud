object frmImportarRelatorios: TfrmImportarRelatorios
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Importar relat'#243'rios'
  ClientHeight = 212
  ClientWidth = 277
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge: TGauge
    Left = 66
    Top = 119
    Width = 143
    Height = 18
    Progress = 0
  end
  object rgTiposRelatorio: TRadioGroup
    Left = 45
    Top = 24
    Width = 185
    Height = 73
    BiDiMode = bdLeftToRight
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'EXCEL'
      'TXT')
    ParentBiDiMode = False
    TabOrder = 0
  end
  object btnImportar: TButton
    Left = 96
    Top = 155
    Width = 81
    Height = 33
    Caption = 'Importar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnImportarClick
  end
  object AGrid: TStringGrid
    Left = 207
    Top = 158
    Width = 62
    Height = 46
    TabOrder = 2
    Visible = False
  end
  object odSubirArquivo: TOpenDialog
    Left = 48
    Top = 160
  end
end
