object frmBaixarRelatorios: TfrmBaixarRelatorios
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Baixar relat'#243'rios'
  ClientHeight = 219
  ClientWidth = 280
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
    Left = 69
    Top = 125
    Width = 140
    Height = 20
    Progress = 0
  end
  object rgTiposRelatorio: TRadioGroup
    Left = 48
    Top = 16
    Width = 185
    Height = 89
    BiDiMode = bdLeftToRight
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'EXCEL'
      'TXT')
    ParentBiDiMode = False
    TabOrder = 0
  end
  object btnBaixar: TButton
    Left = 96
    Top = 163
    Width = 81
    Height = 33
    Caption = 'Baixar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnBaixarClick
  end
end
