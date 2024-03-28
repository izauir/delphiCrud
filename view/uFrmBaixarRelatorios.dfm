object frmBaixarRelatorios: TfrmBaixarRelatorios
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Baixar relat'#243'rios'
  ClientHeight = 212
  ClientWidth = 357
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
    Left = 104
    Top = 125
    Width = 153
    Height = 20
    Progress = 0
  end
  object rgTiposRelatorio: TRadioGroup
    Left = 48
    Top = 16
    Width = 257
    Height = 89
    BiDiMode = bdLeftToRight
    Columns = 4
    ItemIndex = 0
    Items.Strings = (
      'EXCEL'
      'TXT'
      'XML'
      'RAVE')
    ParentBiDiMode = False
    TabOrder = 0
  end
  object btnBaixar: TButton
    Left = 136
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
  object rvProject: TRvProject
    Engine = rvSystem
    Left = 320
    Top = 24
  end
  object rvSystem: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'Rave Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 320
    Top = 56
  end
  object rvRenderPdf: TRvRenderPDF
    DisplayName = 'Adobe Acrobat (PDF)'
    FileExtension = '*.pdf'
    EmbedFonts = False
    ImageQuality = 90
    MetafileDPI = 300
    FontEncoding = feWinAnsiEncoding
    DocInfo.Creator = 'Rave Reports (http://www.nevrona.com/rave)'
    DocInfo.Producer = 'Nevrona Designs'
    BufferDocument = True
    DisableHyperlinks = False
    Left = 320
    Top = 88
  end
end
