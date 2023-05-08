unit Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects,
  FMX.Objects, FB4D.RealTimeDB, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Edit,   FB4D.Authentication, FB4D.Helpers, System.StrUtils, System.JSON,
{$IFDEF TOKENJWT}
  FB4D.OAuth,
{$ENDIF}
  FB4D.Response, FB4D.Request, FB4D.Functions, FB4D.Storage,
  FB4D.Firestore, FB4D.Document, FB4D.VisionMLDefinition, FB4D.VisionML,
  FB4D.Configuration, FB4D.Interfaces, FMX.TabControl, Skia, Skia.FMX;

type
  TLoginForm = class(TForm)
    Rectangle1: TRectangle;
    ShadowEffect1: TShadowEffect;
    edtEmail: TEdit;
    edtPassword: TEdit;
    btnLogin: TButton;
    DEVbtn: TCornerButton;
    StyleBook1: TStyleBook;
    TabControl1: TTabControl;
    Login: TTabItem;
    Register: TTabItem;
    Text1: TText;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Circle1: TCircle;
    SkSvg1: TSkSvg;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    procedure btnLoginClick(Sender: TObject);



    Procedure OnUserResponse(const Info: string;
              User: IFirebaseUser);
    procedure OnUserError(const Info, ErrMsg: string);
    procedure FormCreate(Sender: TObject);
    procedure DEVbtnClick(Sender: TObject);
    procedure Text1Click(Sender: TObject);

  private
  fAuth: IFirebaseAuthentication;
    fOnUserLogin: TOnUserResponse;
    fAllowSelfRegistration: boolean;
    fRequireVerificatedEMail: boolean;
    fRegisterDisplayName: boolean;
    fRealTimeDB: IRealTimeDB;
    fRegisterProfileImg: boolean;
    fStorage: IFirebaseStorage;
    fStoragePath: string;
    fReqInfo: string;
    fInfo: string;
    fUser: IFirebaseUser;
    fTokenRefreshed: boolean;
    fProfileLoadStream: TMemoryStream;
    fProfileImgSize: integer;
    fProfileURL: string;
    fProfileImg: TBitmap;
    fDefaultProfileImg: TBitmap;

    Data : TJSONObject;


    function GetRTDBPath(RStr: String): TStringDynArray;

  public
    uUID: String;
    function PATCHDB (Data: TJSONOBject; uuid : String): Integer;
  end;

var
  LoginForm: TLoginForm;

implementation

{$R *.fmx}

uses Clicker;

resourcestring
  rsEnterEMail = 'Enter your e-mail address for sign-in or registration';
  rsWait = 'Please wait for Firebase';
  rsEnterPassword = 'Enter your password for registration';
  rsSetupPassword = 'Setup a new password for future registrations';
  rsNotRegisteredEMail = 'The entered e-mail is not registered';
  rsPleaseCheckEMail = 'Please check your e-mail inbox to renew your password';
  rsLoggedIn = 'Successful logged in';
  rsPleaseCheckEMailForVerify =
    'Please check your e-mail inbox to confirm your email address';
  rsWriteProfileData = 'Your %s will be registrated';
  rsUserError = 'Access of user data failed: %s';
  rsProfileLoadErr = 'Load of your profile photo is failed: %s';

const
  WebAPI      = 'AIzaSyB4cxU8jQCACBDfJhbL46BJ-Ns54_Wapyw';
  ProjektID   = 'clicker-7af6d';
  RBURL       = 'https://clicker-7af6d-default-rtdb.europe-west1.firebasedatabase.app/';


procedure TLoginForm.btnLoginClick(Sender: TObject);

begin
  if TFirebaseHelpers.IsEMailAdress(edtEMail.Text) then begin
      fAuth.SignInWithEmailAndPassword(edtEmail.Text, edtPassword.Text,
        OnUserResponse, OnUserError);
  end;

end;

function TLoginForm.GetRTDBPath(RStr: String): TStringDynArray;
begin
  result := SplitString(RStr.Replace('\', '/'), '/');
end;

function TLoginForm.PATCHDB (Data: TJSONObject; uuid : String): Integer;
var
  Val: TJSONValue;
begin
  Val := nil;
  try
    try
      Val := fRealTimeDB.PatchSynchronous(GetRTDBPath(uuid), Data);
    except
      on e: exception do
        ShowMessage(e.Message);
    end;
  finally
    Val.Free;
    Data.Free;
  end;
end;

procedure TLoginForm.OnUserResponse(const Info: string;
  User: IFirebaseUser);
begin
  ShowMessage('Logged IN');
  uUID := User.UID;

  Data := TJSONObject.Create;
  Data.AddPair('111','11111');

  PATCHDB(Data,uUID);

  LoginForm.Close;
end;

procedure TLoginForm.Text1Click(Sender: TObject);
begin

  //TabControl1.ActiveTab:=Register;
end;

procedure TLoginForm.DEVbtnClick(Sender: TObject);
begin
  if TFirebaseHelpers.IsEMailAdress('pokegoleon11@gmail.com') then begin
    fAuth.SignInWithEmailAndPassword('pokegoleon11@gmail.com', 'keineahnung',
      OnUserResponse, OnUserError);
  end;
end;

procedure TLoginForm.FormCreate(Sender: TObject);
begin
  fAuth := TFirebaseAuthentication.Create(WebAPI);
  fRealTimeDB := TRealTimeDB.CreateByURL(RBURL, fAuth);
end;

procedure TLoginForm.OnUserError(const Info, ErrMsg: string);
begin
  ShowMessage(Info + ' failed: ' + ErrMsg);
end;

end.
