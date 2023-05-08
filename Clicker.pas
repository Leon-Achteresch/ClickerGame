unit Clicker;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, Skia, Skia.FMX,
  System.ImageList, FMX.ImgList, FMX.Effects, FMX.Ani, FMX.TabControl, Generics.Collections,System.JSON
  ,System.IOUtils;

type
   TUpgrade = record
      Name  : String;
      Value : Double;
      Price : Integer;
      Level : Integer;
   end;

  TClickerForm = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    CornerButton2: TCornerButton;
    ImageList1: TImageList;
    StyleBook1: TStyleBook;
    TabControl1: TTabControl;
    Clicker: TTabItem;
    Profil: TTabItem;
    Oben: TPanel;
    Layout4: TLayout;
    Rectangle1: TRectangle;
    ShadowEffect1: TShadowEffect;
    CoinsText: TText;
    BtnPB: TCornerButton;
    Rectangle3: TRectangle;
    CpS: TText;
    Layout5: TLayout;
    Text1: TText;
    BtnShop: TCornerButton;
    Shop: TTabItem;
    Rectangle4: TRectangle;
    ShadowEffect3: TShadowEffect;
    VertScrollBox1: TVertScrollBox;
    CornerButton6: TCornerButton;
    Rectangle6: TRectangle;
    Rectangle7: TRectangle;
    Layout10: TLayout;
    Layout11: TLayout;
    Text7: TText;
    Layout8: TLayout;
    Text6: TText;
    Text8: TText;
    Layout16: TLayout;
    CornerButton4: TCornerButton;
    Rectangle11: TRectangle;
    CornerButton5: TCornerButton;
    CornerButton7: TCornerButton;
    Rectangle5: TRectangle;
    GradientAnimation1: TGradientAnimation;
    ShadowEffect4: TShadowEffect;
    Rectangle8: TRectangle;
    ShadowEffect5: TShadowEffect;
    CornerButton1: TCornerButton;
    SkSvg1: TSkSvg;
    ShadowEffect2: TShadowEffect;

    procedure FormCreate(Sender: TObject);
    procedure BtnPBClick(Sender: TObject);
    procedure CoinClick(Sender: TObject);
    function  ClearMyRectangles(AParent: TVertScrollBox): Boolean;

    procedure CreateTextAtCursorPos(const X, Y: Single; const Parent: TFmxObject);
    procedure BtnShopClick(Sender: TObject);
    procedure SkSvg1Click(Sender: TObject);
    procedure UpgradeBtnClick(Sender: TObject);
    procedure CornerButton4Click(Sender: TObject);
    procedure CornerButton7Click(Sender: TObject);

    function GetData(): Integer;
    function SaveData(): Integer;

    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormFocusChanged(Sender: TObject);

  private

    aClickValue  : Double;
    UpgradeList: TList<TUpgrade>;

    Connection : Boolean;

    procedure AniFinish(Sender: TObject);
    function Upgrade(const oldValue,newValue: Double; price : Integer): Integer;
    function UpdateShop(): Integer;
    function SetValue(): Integer;
    function CreateMyRectangle(AOwner: TComponent; AParent: TVertScrollBox; AName: string; i: Integer): TRectangle;
    function ExtractNumberFromButtonName(const AName: string): Integer;
    const FileName: String = 'content.json';
  public
    aCoins       : Double;

  end;

var
  ClickerForm: TClickerForm;

implementation

{$R *.fmx}

uses Games, Login;
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}

procedure TClickerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
SaveData;
end;

procedure TClickerForm.FormCreate(Sender: TObject);
var
  Upgrade: TUpgrade;
  i: Integer;
begin
 aClickValue:= 1;
 TabControl1.ActiveTab:= Clicker;
 CPS.Text:= CPS.Text + aClickValue.ToString;
 UpgradeList := TList<TUpgrade>.Create;
 ////
 Connection:=False;
 ////
 if Connection then begin

  Application.CreateForm(TLoginForm, LoginForm);
  Login.LoginForm.ShowModal;

 end else begin

   if not FileExists(FileName) then begin

   //////// Record F�llen
    Upgrade.Name := 'Doppelklick-Boost';
    Upgrade.Value := 1.5;
    Upgrade.Price := 100;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'Klick-Rausch';
    Upgrade.Value := 2.0;
    Upgrade.Price := 150;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'Klick-K�nig';
    Upgrade.Value := 2.5;
    Upgrade.Price := 200;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'Klick-Kraftwerk';
    Upgrade.Value := 3.0;
    Upgrade.Price := 250;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'M�nzen-Magnet';
    Upgrade.Value := 1.2;
    Upgrade.Price := 75;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'Klick-Kombo';
    Upgrade.Value := 1.8;
    Upgrade.Price := 120;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'Turbo-Clicker';
    Upgrade.Value := 4.0;
    Upgrade.Price := 300;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'Klick-Wunder';
    Upgrade.Value := 3.5;
    Upgrade.Price := 275;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'Coin-Generator';
    Upgrade.Value := 1.3;
    Upgrade.Price := 90;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'Klick-Multiplikator';
    Upgrade.Value := 2.2;
    Upgrade.Price := 175;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'Meister-Klicker';
    Upgrade.Value := 2.7;
    Upgrade.Price := 225;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'M�chtiger Klick';
    Upgrade.Value := 3.2;
    Upgrade.Price := 275;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'Super-Coin-Boost';
    Upgrade.Value := 1.6;
    Upgrade.Price := 100;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'Klick-Power-Up';
    Upgrade.Value := 2.3;
    Upgrade.Price := 150;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'Goldrausch';
    Upgrade.Value := 2.8;
    Upgrade.Price := 200;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'Klick-Explosion';
    Upgrade.Value := 3.3;
    Upgrade.Price := 250;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);

    Upgrade.Name := 'Klick-Maschine';
    Upgrade.Value := 3.8;
    Upgrade.Price := 300;
    Upgrade.Level := 0;
    UpgradeList.Add(Upgrade);
   end else begin
     GetData;
     SetValue;
   end;
 end;
 CoinsText.Text:= aCoins.ToString;


end;

procedure TClickerForm.FormDestroy(Sender: TObject);
begin
SaveData;
end;

procedure TClickerForm.FormFocusChanged(Sender: TObject);
begin
CoinsText.Text := aCoins.ToString;
end;

function TClickerForm.UpdateShop(): Integer;
begin

end;

function TClickerForm.SetValue(): Integer;
var
  i, Level: Integer;
  Multiplier : Double;
begin
  for i := 0 to UpgradeList.Count-1 do begin
    Level := UpgradeList[i].Level;
    if Level>0 then begin           // das Level entspricht der Anzahl an Upgrades
    Multiplier := ((Level) * 0.1);  // Berechnung des Multipliers
    aClickValue := aClickValue + UpgradeList[i].Value * Multiplier;
    end else Continue;
  end;
  CPS.Text:= 'Click Mulitplier: '+ aClickValue.ToString;
end;

function TClickerForm.CreateMyRectangle(AOwner: TComponent; AParent: TVertScrollBox; AName: string; i: Integer): TRectangle;
var
  MyLayout: TLayout;
  Text1, Text2, Text3: TText;
  MyButton: TCornerButton;
begin
  ClearMyRectangles(AParent);

  Result := TRectangle.Create(AOwner);
  Result.Parent := AParent;
  Result.Name := AName;
  Result.Align := TAlignLayout.Top;
  Result.Margins.Left := 10;
  Result.Margins.Top := 10;
  Result.Margins.Right := 10;
  Result.Position.X := 10;
  Result.Position.Y := 10;
  Result.Size.Width := 353;
  Result.Size.Height := 86;
  Result.Size.PlatformDefault := False;
  Result.Stroke.Thickness := 0.3;
  Result.XRadius := 10;
  Result.YRadius := 10;

  MyLayout := TLayout.Create(Result);
  MyLayout.Parent := Result;
  MyLayout.Align := TAlignLayout.Client;
  MyLayout.Margins.Left := 10;
  MyLayout.Size.Width := 214;
  MyLayout.Size.Height := 86;
  MyLayout.Size.PlatformDefault := False;
  MyLayout.TabOrder := 1;

  Text1 := TText.Create(MyLayout);
  Text1.Parent := MyLayout;
  Text1.Align := TAlignLayout.Top;
  Text1.Size.Width := 214;
  Text1.Size.Height := 33;
  Text1.Size.PlatformDefault := False;
  Text1.Text := UpgradeList[i].Name;
  Text1.TextSettings.Font.Size := 14;
  //Text1.TextSettings.Font.StyleExt := [TFontStyle.fsBold];
  Text1.TextSettings.HorzAlign := TTextAlign.Leading;

  Text2 := TText.Create(MyLayout);
  Text2.Parent := MyLayout;
  Text2.Align := TAlignLayout.Client;
  Text2.Size.Width := 214;
  Text2.Size.Height := 28;
  Text2.Size.PlatformDefault := False;
  Text2.Text := 'x'+ UpgradeList[i].Value.ToString +'Multiplier';
  //Text2.TextSettings.Font.StyleExt := [];
  Text2.TextSettings.HorzAlign := TTextAlign.Leading;

  Text3 := TText.Create(MyLayout);
  Text3.Parent := MyLayout;
  Text3.Align := TAlignLayout.Bottom;
  Text3.Position.Y := 61;
  Text3.Size.Width := 214;
  Text3.Size.Height := 25;
  Text3.Size.PlatformDefault := False;
  Text3.Text := 'Level:'+ UpgradeList[i].Level.ToString +'|'+ 'Kosten:'+ UpgradeList[i].Price.ToString;
  Text3.TextSettings.HorzAlign := TTextAlign.Leading;

  MyButton := TCornerButton.Create(Result);
  MyButton.Parent := Result;
  MyButton.Name := 'UpgradeButton' + i.ToString;
  MyButton.Text := '';
  MyButton.Align := TAlignLayout.Right;
  MyButton.Images := ImageList1;
  MyButton.ImageIndex := 2;
  MyButton.Position.X := 297;
  MyButton.Sides := [TSide.Top, TSide.Left, TSide.Bottom, TSide.Right];
  MyButton.Size.Width := 56;
  MyButton.Size.Height := 86;
  MyButton.Size.PlatformDefault := False;
  MyButton.StyleLookup := 'CornerButtonstyle';
  MyButton.TabOrder := 0;
  MyButton.XRadius := 3;
  MyButton.YRadius := 3;

  MyButton.OnClick := UpgradeBtnClick;

  with TRectangle.Create(Result) do begin
      Parent := Result;
      Align := TAlignLayout.Left;
      //Fill.Color := claAqua;
      Size.Width := 73;
      Size.Height := 86;
      Size.PlatformDefault := False;
      Stroke.Thickness := 0;
  end;
end;


function TClickerForm.ClearMyRectangles(AParent: TVertScrollBox): Boolean;
var
i: Integer;
begin
Result := False;
for i := AParent.ComponentCount - 1 downto 0 do
if AParent.Components[i] is TRectangle then
AParent.Components[i].Free;
Result := True;
end;

function TClickerForm.GetData(): Integer;
var
  JSON: TJSONObject;
  UpgradeArray: TJSONArray;
  Upgrade: TUpgrade;
  I: Integer;
begin
  Result := -1;
  if not FileExists(FileName) then
    Exit;
  JSON := TJSONObject.ParseJSONValue(TFile.ReadAllText(FileName)) as TJSONObject;
  if JSON = nil then
    Exit;
  try
    UpgradeArray := JSON.GetValue('upgrades') as TJSONArray;
    for I := 0 to UpgradeArray.Count - 1 do
    begin
      Upgrade.Name := UpgradeArray.Items[I].GetValue<string>('name');
      Upgrade.Value := UpgradeArray.Items[I].GetValue<double>('value');
      Upgrade.Price := UpgradeArray.Items[I].GetValue<Integer>('price');
      Upgrade.Level := UpgradeArray.Items[I].GetValue<Integer>('level');
      UpgradeList.Add(Upgrade);
    end;
    aCoins := JSON.GetValue('coins').Value.ToDouble;

    Result := 0;
  finally
    JSON.Free;
  end
end;

procedure TClickerForm.SkSvg1Click(Sender: TObject);
begin
  TabControl1.ActiveTab:= Clicker;
end;

function TClickerForm.SaveData: Integer;
var
  JSON: TJSONObject;
  UpgradeArray: TJSONArray;
  Upgrade: TUpgrade;
  I: Integer;
begin
  JSON := TJSONObject.Create;
  try
    UpgradeArray := TJSONArray.Create;
    for I := 0 to UpgradeList.Count - 1 do begin
      Upgrade := UpgradeList[I];
      UpgradeArray.AddElement(TJSONObject.Create
        .AddPair('name', Upgrade.Name)
        .AddPair('value', TJSONNumber.Create(Upgrade.Value))
        .AddPair('price', TJSONNumber.Create(Upgrade.Price))
        .AddPair('level', TJSONNumber.Create(Upgrade.Level)));
    end;
    JSON.AddPair('upgrades', UpgradeArray);
    JSON.AddPair('coins', TJSONNumber.Create(aCoins));
    TFile.WriteAllText(FileName, JSON.Format);
  finally
    JSON.Free;
  end;
end;

procedure TClickerForm.UpgradeBtnClick(Sender: TObject);
var
  MyButton: TCornerButton;
  BtnName: string;
  UpgradeIndex: Integer;
  UpgradeObject: TUpgrade;
begin
 MyButton := Sender as TCornerButton;

  if Sender = BtnPB then begin
    if aCoins>=10 then begin
     Upgrade(aClickValue, 2, 10);
    end else ShowMessage('Nicht gen�gend Coins');

  end else if Sender = MyButton then begin
    BtnName := TCornerButton(Sender).Name;
    UpgradeIndex := ExtractNumberFromButtonName(BtnName);
    if UpgradeIndex >= 0 then begin

      if aCoins>=UpgradeList[UpgradeIndex].Price then begin;
        Upgrade(aClickValue, UpgradeList[UpgradeIndex].Value + ((UpgradeList[UpgradeIndex].Level - 1) * 0.1), UpgradeList[UpgradeIndex].Price);

        UpgradeObject := UpgradeList[UpgradeIndex];
        UpgradeObject.Level := UpgradeObject.Level + 1;
        UpgradeList[UpgradeIndex] := UpgradeObject;
      end else ShowMessage('Nicht gen�gend Coins');

    end;
  end;
end;

procedure TClickerForm.BtnPBClick(Sender: TObject);
begin
 TabControl1.ActiveTab:= Profil;
end;

procedure TClickerForm.BtnShopClick(Sender: TObject);
var
  MyRectangle: TRectangle;
  i:Integer;
begin
 TabControl1.SetActiveTabWithTransition(Shop, TTabTransition.Slide);
 i := UpgradeList.Count-1;
 while i>=0 do begin
  MyRectangle := CreateMyRectangle(Self, VertScrollBox1, 'MyRectangle' + IntToStr(i), i);

  i:=i-1;
 end;
end;

function TClickerForm.ExtractNumberFromButtonName(const AName: string): Integer;
var
  i: Integer;
  s: string;
begin
  // Schneide den Namen auf die Zahlen am Ende zu
  s := '';
  for i := Length(AName) downto 1 do
  begin
    if CharInSet(AName[i], ['0'..'9']) then
      s := AName[i] + s
    else
      Break;
  end;
  // Konvertiere die extrahierten Zahlen in einen Integer
  Result := StrToIntDef(s, -1);
end;


procedure TClickerForm.CoinClick(Sender: TObject);
begin
 aCoins := aCoins + aClickValue;

 // Erstelle Textobjekt an Klick-Position
 CreateTextAtCursorPos(aCoins + random(100), aCoins + random(100), CornerButton2);

 CoinsText.Text := aCoins.ToString;
end;

procedure TClickerForm.CornerButton4Click(Sender: TObject);
begin
  TabControl1.ActiveTab:= Clicker;
end;

procedure TClickerForm.CornerButton7Click(Sender: TObject);
begin
 Games.GamesForm.Show;
end;

function TClickerForm.Upgrade(const oldValue,newValue: Double; price : Integer): Integer;
begin
    aClickValue:=aClickValue + newValue;
    aCoins:= aCoins-price;
    CPS.Text:= 'Click Mulitplier: '+ aClickValue.ToString;
    CoinsText.Text := aCoins.ToString;
end;

procedure TClickerForm.CreateTextAtCursorPos(const X, Y: Single; const Parent: TFmxObject);
var
    TextObj: TText;
    Animation: TFloatAnimation;
begin
  TextObj := TText.Create(Parent);
  TextObj.Position.Point := TPointF.Create(X, Y);
  TextObj.Text := '+' + aClickValue.ToString;
  Parent.AddObject(TextObj);

  Animation := TFloatAnimation.Create(nil);
  Animation.Parent := TextObj;
  Animation.PropertyName := 'Opacity';
  Animation.StartValue := 1;
  Animation.StopValue := 0;
  Animation.Duration := 2;
  Animation.AnimationType := TAnimationType.In;
  Animation.Tag := NativeInt(TextObj); // TextObj als Tag setzen
  Animation.OnFinish := AniFinish;
  Animation.Start;
end;

procedure TClickerForm.AniFinish(Sender: TObject);
var
  Animation: TFloatAnimation;
  TextObj: TText;
begin
  Animation := TFloatAnimation(Sender);
  TextObj := TText(Animation.Tag); // TextObj aus Tag abrufen

//  if Assigned(TextObj) then
//    Parent.RemoveObject(TextObj);

  if Assigned(Animation) then
    Animation.Free;
end;


end.
