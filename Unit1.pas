unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, advlued, AdvEdit, ExtCtrls, jpeg, pngimage,ShellApi;

type
  TForm1 = class(TForm)
    L0: TLabel;
    Edit1: TAdvLUEdit;
    L1: TLabel;
    L2: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EX1: TLabel;
    EX2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EX3: TLabel;
    Label9: TLabel;
    EX4: TLabel;
    Label4: TLabel;
    EX5: TLabel;
    Image1: TImage;
    Image2: TImage;
    procedure Edit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EX1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
       sList:TStringList;
    //�P�_�Y�@�Ӧr���O�_�����媺�e�ɦr��
      function IsLeadByteTw(c:AnsiChar):Boolean;
      //�p�⤤��r������(�ק�� MS Access 7.0 NorthWind �d��);
      //�Ǧ^��:0 ��ܫD����r, �_�h�����嵧����.
       function NumStrokes(cstr: AnsiString):Integer;
     //�p��r�ꪺ�`����
       function TotalStrokes(cstr: string):Integer;
       procedure MakeList;
       procedure FetChText(msIndex:integer);
       procedure GoWeb(FURL:string);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
const
 showStr = '��J�۵P �n�O���W������W';


{ TForm1 }

procedure TForm1.Edit1Change(Sender: TObject);
var
  mmText:string;
begin

  //L_WordCount.Caption := inttostr(TotalStrokes ( Edit1.Text));
  mmText :=  Edit1.Text;
  if (Length(mmText)> 161) then mmText := Copy(mmText,1,161);

  FetChText(TotalStrokes (mmText));

end;



procedure TForm1.EX1Click(Sender: TObject);
begin
  Edit1.Text := Tlabel(Sender).Caption;
end;

procedure TForm1.FetChText(msIndex: integer);
var
 mText:string;
 ML0,ML1,ML2:string;
 DashPOS:integer;
 mIndex: integer;
begin
   mIndex := msIndex;
   if (msIndex < 1) or (msIndex > 161) then begin
     L0.Caption := '';
     L1.Caption := '';
     L2.Caption := '';
     exit;
   end;

   if (msIndex > 81)  then begin
     mIndex := msIndex -80;
   end;


    mText :=  sList.Strings[mIndex-1];
  //��

    DashPOS := POS('>',mText);


    ML0 :=  Copy(mText,2,DashPOS-1);
    ML1 :=  Copy(mText,1,1);
    ML2 :=  Copy(mText,DashPOS+1,Length(mText)- DashPOS);


    L0.Caption := ML0;
    L1.Caption := ML1;
    L2.Caption := ML2;



    if ML1='�N' then L1.Font.Color := CLred else L1.Font.Color := CLBlack;








   // L_WordCount.Caption := mText;


end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  MakeList;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   Edit1.EmptyText := showStr;
   L0.Caption := '';
   L1.Caption := '';
   L2.Caption := '';
end;

procedure TForm1.GoWeb(FURL: string);
var
  S: string;
  ShellInfo: TShellExecuteInfo;
begin
  if Trim( FURL ) = '' then
    S := Caption
  else
    S := FURL;

  if Trim( S ) <> '' then
  begin
    FillChar( ShellInfo, SizeOf( TShellExecuteInfo ), 0 );
    ShellInfo.cbSize := SizeOf( TShellExecuteInfo );
    ShellInfo.fMask := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_NO_UI or
                       SEE_MASK_FLAG_DDEWAIT;
    ShellInfo.Wnd := HWnd_Desktop;
    ShellInfo.lpVerb := 'Open';
    ShellInfo.lpFile := PChar( S );
    ShellInfo.lpParameters := nil;
    ShellInfo.lpDirectory := nil;
    ShellInfo.nShow := sw_ShowNormal;

    if ShellExecuteEx( @ShellInfo ) then begin
      // Visited := True
    end else begin
      if UpperCase( ExtractFileExt( S ) ) = '.HTM' then
        WinExec( 'RunDLL32.exe Shell32.dll,OpenAs_RunDLL *.htm', sw_ShowNormal );
    end;
  end;
end;


procedure TForm1.Image1Click(Sender: TObject);
begin
  GoWeb('http://advpos.weebly.com/');
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
   GoWeb('http://e-computer.no-ip.org/edm.htm');
end;

function TForm1.IsLeadByteTw(c: AnsiChar): Boolean;
begin
   //�ھڪ������ε{������"�r��������"�p��ӱo ($81 .. $FE)
    Result:=(c in [Char($81)..Char($FE)]);
    {
    //�I�s Windows API �ӭp�� (���Ĳv���t)
    Result:=IsDBCSLeadByte(Byte(c));
    }


end;

procedure TForm1.MakeList;
begin
  sList:= TStringList.Create;
  sList.Add('�N<�@��>�c�a�o�F�A�H�αo�T�A�U�H����A�i�򦨥\�C ');
  sList.Add('��<�G��>�ʷn���w�A�@�a�@�\�A�@���@�I�A�ҦӵL�\�C ');
  sList.Add('�N<�T��>�ߨ��B�@�A���Q�H�U�A�ѽ�N���A�|�����W�C ');
  sList.Add('��<�|��>��Q���B�A�W����i�A�D���ݤO�A���榨�\�C ');
  sList.Add('�N<����>�����M�X�A�믫�r�֡A�a�A�F�Q�A�@�������C ');
  sList.Add('�N<����>�U�_�����A�ѭ����B�A�ߧӾĵo�A�o���j�~�C ');
  sList.Add('�N<�C��>��O�����A�Y�����ӡA�ư��U���A���򦨥\�C ');
  sList.Add('�N<�K��>�V�O�o�F�A�e���N�@�A���Ѷi�h�A�i�����\�C ');
  sList.Add('��<�E��>����_�~�A���~�L�R�A�W��L�O�A�]�Q����C ');
  sList.Add('��<�Q��>�Q���B��A�t�H�L���A�ŶO�ߤO�A�{�ҵL�\�C ');
  sList.Add('�N<�Q�@��>���{�K�A�K���g�S�Aí���۹�A���o�H��C ');
  sList.Add('��<�Q�G��>���z�L�O�A�t�ߵL���A�~�����W�A�Ѩ������C ');
  sList.Add('�N<�Q�T��>�ѽ�N�B�A��o�H��A���δ��ѡA���򦨥\�C ');
  sList.Add('��<�Q�|��>�Աo�W���A������֡A�O���O�ѡA���a��ݡC ');
  sList.Add('�N<�Q����>�������ơA�~�o�H�M�A�j�Ʀ��N�A�@�������C ');
  sList.Add('�N<�Q����>���򲳱�A���N�j�~�A�W�Q�����A���D�|��C ');
  sList.Add('�N<�Q�C��>�ư��U���A���Q�H�U�A�ⴤ�ɾ��A�i�򦨥\�C ');
  sList.Add('�N<�Q�K��>�g�簵�ơA���Q�����A�p��V���A�ʨƦ�q�C ');
  sList.Add('��<�Q�E��>���\�����A�V�����šA���~���M�A��ê�����C ');
  sList.Add('��<�G�Q��>�����Ӥj�A�����}���A�J�߼~�ҡA�i�h�����C');
  sList.Add('�N<�G�Q�@��>�����x�W�A��o���֡A��������A�K�ӫ��C');
  sList.Add('��<�G�Q�G��>���{���A�h�~���J�A�~�T��W�A�Ƥ��p�N�C');
  sList.Add('�N<�G�Q�T��>����ɤѡA�W��|��A�����i�i�A�צ��j�~�C');
  sList.Add('�N<�G�Q�|��> �A¸�e�{�A�ݾa�ۥߡA�h�δ��ѡA�૵�j�\�C');
  sList.Add('�N<�G�Q����>�Ѯɦa�Q�A�u��H�M�A���H�׷��A�Y�i���\�C');
  sList.Add('��<�G�Q����>�i�i�_��A�d�ܸU�ơA��r�U���A���i���\�C');
  sList.Add('��<�G�Q�C��>�@���@�ѡA�@���@�I�A���a�ԷV�A�צ��j�~�C');
  sList.Add('��<�G�Q�K��>���{��a�A���k�̹B�A���Ƥj���A���p��W�C');
  sList.Add('�N<�G�Q�E��>�p�s�o���A�C�����W�A���ѾĶi�A�~�����\�C');
  sList.Add('��<�T�Q��>�N���ѥb�A�o���ۦ�A��������A�j�����I�C');
  sList.Add('�N<�T�Q�@��>���Ƥj�N�A�W�Q�����A���i�V�W�A�j�~���N�C');
  sList.Add('�N<�T�Q�G��>�������s�A�����ڷ|�A�@�D�W�ѡA���\�i��C');
  sList.Add('�N<�T�Q�T��>�N��ΨơA�H�M�����A�p��V�l�A���i�����C');
  sList.Add('��<�T�Q�|��>�a�������A���Ѧ��\�A���Ƥj���A���p��W�C');
  sList.Add('�N<�T�Q����>�B���Y�ԡA�i�h�O�u�A�Ǵ��ݳơA���N�D�Z�C');
  sList.Add('��<�T�Q����>�i�i���|�A�`���x�ҡA�ʤ��p�R�A���]�L�R�C');
  sList.Add('�N<�T�Q�C��>�{���ƦN�A�N�H�ѶH�A�H�w�����A�����j�\�C');
  sList.Add('��<�T�Q�K��>�W���i�o�A�Q�h����A���ɵo�i�A�i�榨�\�C');
  sList.Add('�N<�T�Q�E��>���}����A�����ҸL�A�����Z�~�A����i���C');
  sList.Add('��<�|�Q�s��>�@���@�I�A�I�B���w�A�����Ӱh�A����Ѧ��C');
  sList.Add('�N<�|�Q�@��>�ѽ�N�B�A�w��ݳơA�~��V�O�A�e�~�L���C');
  sList.Add('��<�|�Q�G��>�Ʒ~���M�A�Q�E�����A�M�ߤ����A�i�榨�\�C');
  sList.Add('��<�|�Q�T��>�B�]����A�~�����W�A�ԭ@�ۭ��A�ि���N, ');
  sList.Add('��<�|�Q�|��>���Τ߭p�A�����E�@�A�g�\�n�i�A���ۥ��ѡC');
  sList.Add('�N<�|�Q����>���h�J�K�A�񸭵o�K�A�R�}�����A�@�|���W�C');
  sList.Add('��<�|�Q����>���V�����A�}�������A�Y�L�@�ߡA���榳���C');
  sList.Add('�N<�|�Q�C��>���Q�H�U�A�i���j�~�A���D�����A�I�B���w�C');
  sList.Add('�N<�|�Q�K��>�����׹�A�b�����s�A�W�Q�ѥ��A�c�a�I�Q�C');
  sList.Add('��<�|�Q�E��>�J�N�h�N�A�J���h���A���a�ԷV�A�{���ƦN�C');
  sList.Add('��<���Q��>�N�������A�@���@�ѡA�����a�N�A�N�������C');
  sList.Add('��<���Q�@��>�@���@�I�A�I�B���`�A�ۭ��ӳB�A�i�O���w�C');
  sList.Add('�N<���Q�G��>���{�K�A�B�L�Ѵ��A��L�����A�Y�򦨥\�C');
  sList.Add('��<���Q�T��>���I�ѥb�A�~�����W�A���N�᤿�A������N�C');
  sList.Add('��<���Q�|��>���ɥ��O�A���榨�\�A���Ƥj���A�̦n��W�C');
  sList.Add('��<���Q����>�~�[�����A�����ױw�A�g�A�����A�}�X���B�C');
  sList.Add('��<���Q����>�ƻP�@�H�A�������\�A���t���F�A���l�L�סC');
  sList.Add('��<���Q�C��>�����x���A�ɨӹB��A�m���\��A�K�Ӫ�}�C');
  sList.Add('��<���Q�K��>�b���b�N�A�B�I�h�ݡA�l���צN�A��O���\�C');
  sList.Add('��<���Q�E��>�J�ƵS�ݡA���Ѧ��ơA�j�M���A�l�i���\�C');
  sList.Add('��<���Q��>�·t�L�N�A�߰g�N�áA�X���Ϻ��A���w��w�C');
  sList.Add('��<���Q�@��>���B�b��A�������i�A�����ԷV�A�l�O���w�C');
  sList.Add('��<���Q�G��>�дe�Ҵo�A�Ʒ~���i�A�ۨ��a�סA�l�K�x�ҡC');
  sList.Add('�N<���Q�T��>�U���ƨ|�A�c�a���H�A�M�ߤ@�N�A���ন�\�C');
  sList.Add('��<���Q�|��>������E�A�Q�E�����A�{�ҵL�\�A���p��W�C');
  sList.Add('�N<���Q����>�N�B�ۨӡA��ɲ��W�A�ⴤ���|�A���򦨥\�C');
  sList.Add('��<���Q����>�·t�����A�i�h�����A���~���M�A�H�ίʥF�C');
  sList.Add('�N<���Q�C��>�W��Ʒ~�A�ƨƦp�N�A�\���W�N�A�I�Q�ۨӡC');
  sList.Add('�N<���Q�K��>��{�P�ԡA�p���O��A�����ɾ��A�i�榨�\�C');
  sList.Add('��<���Q�E��>�ʷn���w�A�`���f�ҡA���o�ɹB�A���o�Q��C');
  sList.Add('��<�C�Q�s��>�G�H�g��A���K�h�x�A���Ƥ��N�A�̦n��W�C');
  sList.Add('��<�C�Q�@��>�N���ѥb�A����i��A�e���O��A�l�i���\�C');
  sList.Add('��<�C�Q�G��>�Q�`�V���A���h�N�֡A�o�Ӵ_���A���H�w���C');
  sList.Add('�N<�C�Q�T��>�w�֦ۨӡA�۵M�N���A�O�椣�ӡA���ন�\�C');
  sList.Add('��<�C�Q�|��>�Q���ζO�A�����s�šA�p�L���ѡA���Ѧ��\�C');
  sList.Add('��<�C�Q����>�N���a���A���t���F�A�i���p�u�A�i�O���ԡC');
  sList.Add('��<�C�Q����>���Ƥj���A�}�����H�A�y�t��W�A�H�פ̹B�C');
  sList.Add('��<�C�Q�C��>���W��̡A���̫�W�A�p��u���A���ܥ��ѡC');
  sList.Add('��<�C�Q�K��>���o�����A�ئӤ���A�����T�]�A�l�O�����C');
  sList.Add('��<�C�Q�E��>�p���]���A�e�~�L���A�Ʊ椣�j�A�ҦӵL�\�C');
  sList.Add('��<�K�Q��>�o�Ӵ_���A�P�O�߾��A�u���L�g�A�i�O��í�C');
  sList.Add('�N<�K�Q�@��>�̦N���ơA�٥��k���A��o�c�a�A�o�F���\�C');


end;

function TForm1.NumStrokes(cstr: AnsiString): Integer;
var i:Integer;
begin
    Result:=0;
    if Length(cstr)<2 then exit;
   // if not IsLeadByteTw(cstr[1]) then exit;
    i := (Ord(cstr[1]) shl 8)+Ord(cstr[2]);
    //�@��
    If (i = $A440) Or (i = $A441) Then Result := 1
    //2��
    Else If ((i >= $A442) And (i <= $A453)) Or ((i >= $C940) And (i <= $C944)) Then Result := 2
    //3��
    Else If ((i >= $A454) And (i <= $A47E)) Or ((i >= $C945) And (i <= $C94C)) Then Result := 3
    //4��
    Else If ((i >= $A4A1) And (i <= $A4FD)) Or ((i >= $C94D) And (i <= $C962)) Then Result := 4
    //5��
    Else If ((i >= $A4FE) And (i <= $A5DF)) Or ((i >= $C963) And (i <= $C9AA)) Then Result := 5
    //6��
    Else If ((i >= $A5E0) And (i <= $A6E9)) Or ((i >= $C9AB) And (i <= $CA59)) Then Result := 6
    //7��
    Else If ((i >= $A6EA) And (i <= $A8C2)) Or ((i >= $CA5A) And (i <= $CBB0)) Then Result := 7
    //8��
    Else If (i = $A260) Or ((i >= $A8C3) And (i <= $AB44)) Or ((i >= $CBB1) And (i <= $CDDC)) Then Result := 8
    //9��
    Else If (i = $A259) Or (i = $F9DA) Or ((i >= $AB45) And (i <= $ADBB)) Or ((i >= $CDDD) And (i <= $D0C7)) Then Result := 9
    //10��
    Else If (i = $A25A) Or ((i >= $ADBC) And (i <= $B0AD)) Or ((i >= $D0C8) And (i <= $D44A)) Then Result := 10
    //11��
    Else If (i = $A25B) Or (i = $A25C) Or ((i >= $B0AE) And (i <= $B3C2)) Or ((i >= $D44B) And (i <= $D850)) Then Result := 11
    //12��
    Else If (i = $F9DB) Or ((i >= $B3C3) And (i <= $B6C2)) Or ((i >= $D851) And (i <= $DCB0)) Then Result := 12
    //13��
    Else If (i = $A25D) Or (i = $A25F) Or (i = $C6A1) Or (i = $F9D6) Or (i = $F9D8) Or ((i >= $B6C3) And (i <= $B9AB)) Or ((i >= $DCB1) And (i <= $E0EF)) Then Result := 13
    //14��
    Else If (i = $F9DC) Or ((i >= $B9AC) And (i <= $BBF4)) Or ((i >= $E0F0) And (i <= $E4E5)) Then Result := 14
    //15��
    Else If (i = $A261) Or ((i >= $BBF5) And (i <= $BEA6)) Or ((i >= $E4E6) And (i <= $E8F3)) Then Result := 15
    //16��
    Else If (i = $A25E) Or (i = $F9D7) Or (i = $F9D9) Or ((i >= $BEA7) And (i <= $C074)) Or ((i >= $E8F4) And (i <= $ECB8)) Then Result := 16
    //17��
    Else If ((i >= $C075) And (i <= $C24E)) Or ((i >= $ECB9) And (i <= $EFB6)) Then Result := 17
    //18��
    Else If ((i >= $C24F) And (i <= $C35E)) Or ((i >= $EFB7) And (i <= $F1EA)) Then Result := 18
    //19��
    Else If ((i >= $C35F) And (i <= $C454)) Or ((i >= $F1EB) And (i <= $F3FC)) Then Result := 19
    //20��
    Else If ((i >= $C455) And (i <= $C4D6)) Or ((i >= $F3FD) And (i <= $F5BF)) Then Result := 20
    //21��
    Else If ((i >= $C4D7) And (i <= $C56A)) Or ((i >= $F5C0) And (i <= $F6D5)) Then Result := 21
    //22��
    Else If ((i >= $C56B) And (i <= $C5C7)) Or ((i >= $F6D6) And (i <= $F7CF)) Then Result := 22
    //23��
    Else If ((i >= $C5C8) And (i <= $C5F0)) Or ((i >= $F7D0) And (i <= $F8A4)) Then Result := 23
    //24��
    Else If ((i >= $C5F1) And (i <= $C654)) Or ((i >= $F8A5) And (i <= $F8ED)) Then Result := 24
    //25��
    Else If ((i >= $C655) And (i <= $C664)) Or ((i >= $F8EE) And (i <= $F96A)) Then Result := 25
    //26��
    Else If ((i >= $C665) And (i <= $C66B)) Or ((i >= $F96B) And (i <= $F9A1)) Then Result := 26
    //27��
    Else If ((i >= $C66C) And (i <= $C675)) Or ((i >= $F9A2) And (i <= $F9B9)) Then Result := 27
    //28��
    Else If ((i >= $C676) And (i <= $C678)) Or ((i >= $F9BA) And (i <= $F9C5)) Then Result := 28
    //29��
    Else If ((i >= $C679) And (i <= $C67C)) Or ((i >= $F9C7) And (i <= $F9CB)) Then Result := 29
    //30��
    Else If (i = $C67D) Or ((i >= $F9CC) And (i <= $F9CF)) Then Result := 30
    //30��
    Else If (i = $C67D) Or ((i >= $F9CC) And (i <= $F9CF)) Then Result := 30
    //31��
    Else If (i = $F9D0) Then Result := 31
    //32��
    Else If (i = $C67E) Or (i = $F9D1) Then Result := 32
    //33��
    Else If (i = $F9C6) Or (i = $F9D2) Then Result := 33
    //35��
    Else If (i = $F9D3) Then Result := 35
    //36��
    Else If (i = $F9D4) Then Result := 36
    //48��
    Else If (i = $F9D5) Then Result := 48;


end;





function TForm1.TotalStrokes(cstr: string): Integer;
var
    i,N,L:Integer;
    AWord:string;
    c:string;
begin

      Result:=0;
      N:=0;
      L:=length(cstr);
    if (L=0) then exit;
    for i := 0 to L do begin
      AWord := cstr[i];
      N:= N + NumStrokes(AWord);
    end;
      Result := N;


end;

end.


{







}
