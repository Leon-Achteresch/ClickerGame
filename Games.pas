unit Games;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Skia, Skia.FMX,
  FMX.StdCtrls, FMX.Objects, FMX.Effects, FMX.Layouts, FMX.Controls.Presentation,
  FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.TabControl;

type
  TGamesForm = class(TForm)
    Oben: TPanel;
    Layout4: TLayout;
    Rectangle1: TRectangle;
    ShadowEffect1: TShadowEffect;
    CoinsText: TText;
    Rectangle2: TRectangle;
    ShadowEffect2: TShadowEffect;
    BtnPB: TCornerButton;
    TabControl1: TTabControl;
    Crash: TTabItem;
    Roulette: TTabItem;
    Layout1: TLayout;
    Layout2: TLayout;
    Text1: TText;
    SpinBox1: TSpinBox;
    CornerButton1: TCornerButton;
    Coinflip: TTabItem;
    Layout3: TLayout;
    SpinBox2: TSpinBox;
    CornerButton2: TCornerButton;
    Text2: TText;
    Layout5: TLayout;
    Circle1: TCircle;
    Text3: TText;
    Timer1: TTimer;
    Rectangle3: TRectangle;
    TabItem1: TTabItem;
    Image1: TImage;
    Image2: TImage;
    HEAD: TImage;
    Tails: TImage;
    procedure CornerButton1Click(Sender: TObject);
    procedure CornerButton2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Circle2Click(Sender: TObject);
    procedure Circle3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    BetAmount : Double;
    cfChose   : Integer;

    GlowEffect: TGlowEffect;
  public
    { Public-Deklarationen }
  end;

var
  GamesForm: TGamesForm;

implementation

{$R *.fmx}

uses Clicker;

procedure TGamesForm.Circle2Click(Sender: TObject);
begin
  if not Assigned(GlowEffect) then begin
    GlowEffect := TGlowEffect.Create(Self);
    try
      GlowEffect.Parent := Image1;
      GlowEffect.Softness := 0.5;
      GlowEffect.GlowColor := TAlphaColorRec.Orange;
      GlowEffect.Enabled := True;
    except
      GlowEffect.Free;
    end;
  end else begin
    GlowEffect.Free;
  end;
  cfChose := 1;
end;

procedure TGamesForm.Circle3Click(Sender: TObject);
begin
  if not Assigned(GlowEffect) then begin

    GlowEffect := TGlowEffect.Create(Self);
    try
      GlowEffect.Parent := Image2;
      GlowEffect.Softness := 0.5;
      GlowEffect.GlowColor := TAlphaColorRec.Orange;
      GlowEffect.Enabled := True;
    except
      GlowEffect.Free;
    end;
  end else begin
    GlowEffect.Free;
  end;
  cfChose := 0;
end;

procedure TGamesForm.CornerButton1Click(Sender: TObject);
begin
 BetAmount:=SpinBox1.Value;
end;

procedure TGamesForm.CornerButton2Click(Sender: TObject);
begin
  BetAmount:=SpinBox2.Value;

  Head.Visible:=False;
  Tails.Visible:=False;

  ClickerForm.aCoins:= ClickerForm.aCoins - BetAmount;
  CoinsText.Text:= ClickerForm.aCoins.ToString;

  Text3.Text:= '...............';

  Timer1.Enabled := True;
  Timer1.Interval := 2000;
end;


procedure TGamesForm.FormCreate(Sender: TObject);
begin
cfChose := -1;
end;

procedure TGamesForm.FormShow(Sender: TObject);
begin
  CoinsText.Text:= ClickerForm.aCoins.ToString;
end;

procedure TGamesForm.Timer1Timer(Sender: TObject);
var CoinflipValue: Integer;
begin
   if TabControl1.ActiveTab=Coinflip then begin
    if cfChose>=0 then begin

     CoinflipValue:=Random(2);
     if CoinflipValue=1 then begin
       Text3.Text:= 'Kopf!';
       Head.Visible:=True;
     end else begin
      Text3.Text:= 'Zahl!';
      Tails.Visible:=True;
     end;

     if CoinflipValue=cfChose then begin
      Text3.Text:= Text3.Text + ' DU HAST GEWONNEN!';
      ClickerForm.aCoins:= ClickerForm.aCoins + BetAmount*2;
      CoinsText.Text:= ClickerForm.aCoins.ToString;
     end;

    end else ShowMessage('Wähle eine Seite!');

   end;

  Timer1.Enabled := False;
end;

function CoinFlip: Boolean;
begin
  Randomize;
  Result := Random(2) = 0;
end;

end.
