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
  object pbBarraProgresso: TProgressBar
    Left = 61
    Top = 119
    Width = 150
    Height = 17
    TabOrder = 1
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
    TabOrder = 2
    OnClick = btnImportarClick
  end
  object odSubirArquivo: TOpenDialog
    Left = 48
    Top = 160
  end
end
