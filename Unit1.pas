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
    //判斷某一個字元是否為中文的前導字元
      function IsLeadByteTw(c:AnsiChar):Boolean;
      //計算中文字的筆劃(修改自 MS Access 7.0 NorthWind 範例);
      //傳回值:0 表示非中文字, 否則為中文筆劃數.
       function NumStrokes(cstr: AnsiString):Integer;
     //計算字串的總筆劃
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
 showStr = '輸入招牌 登記店名的中文名';


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
  //比劃

    DashPOS := POS('>',mText);


    ML0 :=  Copy(mText,2,DashPOS-1);
    ML1 :=  Copy(mText,1,1);
    ML2 :=  Copy(mText,DashPOS+1,Length(mText)- DashPOS);


    L0.Caption := ML0;
    L1.Caption := ML1;
    L2.Caption := ML2;



    if ML1='吉' then L1.Font.Color := CLred else L1.Font.Color := CLBlack;








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
   //根據附屬應用程式中的"字元對應表"計算而得 ($81 .. $FE)
    Result:=(c in [Char($81)..Char($FE)]);
    {
    //呼叫 Windows API 來計算 (但效率較差)
    Result:=IsDBCSLeadByte(Byte(c));
    }


end;

procedure TForm1.MakeList;
begin
  sList:= TStringList.Create;
  sList.Add('吉<一劃>繁榮發達，信用得固，萬人仰望，可獲成功。 ');
  sList.Add('凶<二劃>動搖不安，一榮一枯，一盛一衰，勞而無功。 ');
  sList.Add('吉<三劃>立身處世，有貴人助，天賜吉祥，四海揚名。 ');
  sList.Add('凶<四劃>日被雲遮，苦難折磨，非有毅力，難望成功。 ');
  sList.Add('吉<五劃>陰陽和合，精神愉快，榮譽達利，一門興隆。 ');
  sList.Add('吉<六劃>萬寶集門，天降幸運，立志奮發，得成大業。 ');
  sList.Add('吉<七劃>精力旺盛，頭腦明敏，排除萬難，必獲成功。 ');
  sList.Add('吉<八劃>努力發達，貫徹意願，不忘進退，可期成功。 ');
  sList.Add('凶<九劃>雖抱奇才，有才無命，獨營無力，財利難望。 ');
  sList.Add('凶<十劃>烏雲遮月，暗淡無光，空費心力，徒勞無功。 ');
  sList.Add('吉<十一劃>草木逢春，枝葉沾露，穩健著實，必得人望。 ');
  sList.Add('凶<十二劃>薄弱無力，孤立無援，外祥內苦，謀事難成。 ');
  sList.Add('吉<十三劃>天賦吉運，能得人望，善用智謀，必獲成功。 ');
  sList.Add('凶<十四劃>忍得苦難，必有後福，是成是敗，惟靠堅毅。 ');
  sList.Add('吉<十五劃>謙恭做事，外得人和，大事成就，一門興隆。 ');
  sList.Add('吉<十六劃>能獲眾望，成就大業，名利雙收，盟主四方。 ');
  sList.Add('吉<十七劃>排除萬難，有貴人助，把握時機，可獲成功。 ');
  sList.Add('吉<十八劃>經營做事，順利昌隆，如能慎重，百事亨通。 ');
  sList.Add('凶<十九劃>成功雖早，慎防虧空，內外不和，障礙重重。 ');
  sList.Add('凶<二十劃>智高志大，歷盡艱難，焦心憂勞，進退兩難。');
  sList.Add('吉<二十一劃>先歷困苦，後得幸福，霜雪梅花，春來怒放。');
  sList.Add('凶<二十二劃>秋草逢霜，懷才不遇，憂愁怨苦，事不如意。');
  sList.Add('吉<二十三劃>旭日升天，名顯四方，漸次進展，終成大業。');
  sList.Add('吉<二十四劃> 錦繡前程，需靠自立，多用智謀，能奏大功。');
  sList.Add('吉<二十五劃>天時地利，只欠人和，講信修睦，即可成功。');
  sList.Add('平<二十六劃>波瀾起伏，千變萬化，凌駕萬難，必可成功。');
  sList.Add('平<二十七劃>一成一敗，一盛一衰，惟靠謹慎，終成大業。');
  sList.Add('凶<二十八劃>魚臨旱地，難逃厄運，此數大凶，不如更名。');
  sList.Add('吉<二十九劃>如龍得雲，青雲直上，智謀奮進，才略奏功。');
  sList.Add('平<三十劃>吉凶參半，得失相伴，投機取巧，大有風險。');
  sList.Add('吉<三十一劃>此數大吉，名利雙收，漸進向上，大業成就。');
  sList.Add('吉<三十二劃>池中之龍，風雲際會，一躍上天，成功可望。');
  sList.Add('吉<三十三劃>意氣用事，人和必失，如能慎始，必可昌隆。');
  sList.Add('凶<三十四劃>災難不絕，難忘成功，此數大凶，不如更名。');
  sList.Add('吉<三十五劃>處事嚴謹，進退保守，學智兼備，成就非凡。');
  sList.Add('凶<三十六劃>波瀾重疊，常陷困境，動不如靜，有財無命。');
  sList.Add('吉<三十七劃>逢凶化吉，吉人天象，以德取眾，必成大功。');
  sList.Add('平<三十八劃>名雖可得，利則難獲，藝界發展，可望成功。');
  sList.Add('吉<三十九劃>雲開見月，雖有勞碌，光明坦途，指日可期。');
  sList.Add('平<四十零劃>一盛一衰，沉浮不定，知難而退，自獲天佑。');
  sList.Add('吉<四十一劃>天賦吉運，德望兼備，繼續努力，前途無限。');
  sList.Add('平<四十二劃>事業不專，十九不成，專心不移，可望成功。');
  sList.Add('平<四十三劃>雨夜之花，外祥內苦，忍耐自重，轉凶為吉, ');
  sList.Add('凶<四十四劃>雖用心計，事難遂願，貪功好進，必招失敗。');
  sList.Add('吉<四十五劃>楊柳遇春，綠葉發枝，沖破難關，一舉成名。');
  sList.Add('凶<四十六劃>坎坷不平，艱難重重，若無耐心，難望有成。');
  sList.Add('吉<四十七劃>有貴人助，可成大業，雖遭不幸，沉浮不定。');
  sList.Add('吉<四十八劃>美花豐實，鶴立雞群，名利俱全，繁榮富貴。');
  sList.Add('凶<四十九劃>遇吉則吉，遇凶則凶，惟靠謹慎，逢凶化吉。');
  sList.Add('平<五十劃>吉凶互見，一成一敗，凶中帶吉，吉中有凶。');
  sList.Add('平<五十一劃>一盛一衰，沉浮不常，自重而處，可保平安。');
  sList.Add('吉<五十二劃>草木逢春，雨過天晴，渡過難關，即獲成功。');
  sList.Add('平<五十三劃>盛衰參半，外祥內苦，先吉後凶，先凶後吉。');
  sList.Add('凶<五十四劃>雖傾全力，難望成功，此數大凶，最好改名。');
  sList.Add('平<五十五劃>外觀昌隆，內隱禍患，剋服難關，開出泰運。');
  sList.Add('凶<五十六劃>事與願違，終難成功，欲速不達，有始無終。');
  sList.Add('平<五十七劃>雖有困難，時來運轉，曠野枯草，春來花開。');
  sList.Add('平<五十八劃>半凶半吉，浮沉多端，始凶終吉，能保成功。');
  sList.Add('凶<五十九劃>遇事猶豫，難忘成事，大刀闊斧，始可成功。');
  sList.Add('凶<六十劃>黑暗無吉，心迷意亂，出爾反爾，難定方針。');
  sList.Add('平<六十一劃>雲遮半月，內隱風波，應自謹慎，始保平安。');
  sList.Add('凶<六十二劃>煩悶懊惱，事業難展，自防災禍，始免困境。');
  sList.Add('吉<六十三劃>萬物化育，繁榮之象，專心一意，必能成功。');
  sList.Add('凶<六十四劃>見異思遷，十九不成，徒勞無功，不如更名。');
  sList.Add('吉<六十五劃>吉運自來，能享盛名，把握機會，必獲成功。');
  sList.Add('凶<六十六劃>黑暗綿長，進退維谷，內外不和，信用缺乏。');
  sList.Add('吉<六十七劃>獨營事業，事事如意，功成名就，富貴自來。');
  sList.Add('吉<六十八劃>思慮周詳，計劃力行，不失時機，可望成功。');
  sList.Add('凶<六十九劃>動搖不定，常陷逆境，不得時運，難得利潤。');
  sList.Add('凶<七十零劃>慘淡經營，難免貧困，此數不吉，最好更名。');
  sList.Add('平<七十一劃>吉凶參半，惟賴勇氣，貫徹力行，始可成功。');
  sList.Add('凶<七十二劃>利害混雜，凶多吉少，得而復失，難以安順。');
  sList.Add('吉<七十三劃>安樂自來，自然吉祥，力行不懈，必能成功。');
  sList.Add('凶<七十四劃>利不及費，坐食山空，如無智謀，難忘成功。');
  sList.Add('平<七十五劃>吉中帶凶，欲速不達，進不如守，可保全詳。');
  sList.Add('凶<七十六劃>此數大凶，破產之象，宜速改名，以避厄運。');
  sList.Add('平<七十七劃>先苦後甘，先甘後苦，如能守成，不至失敗。');
  sList.Add('平<七十八劃>有得有失，華而不實，須防劫財，始保全順。');
  sList.Add('凶<七十九劃>如走夜路，前途無光，希望不大，勞而無功。');
  sList.Add('平<八十劃>得而復失，枉費心機，守成無貪，可保全穩。');
  sList.Add('吉<八十一劃>最吉之數，還本歸元，能得繁榮，發達成功。');


end;

function TForm1.NumStrokes(cstr: AnsiString): Integer;
var i:Integer;
begin
    Result:=0;
    if Length(cstr)<2 then exit;
   // if not IsLeadByteTw(cstr[1]) then exit;
    i := (Ord(cstr[1]) shl 8)+Ord(cstr[2]);
    //一劃
    If (i = $A440) Or (i = $A441) Then Result := 1
    //2劃
    Else If ((i >= $A442) And (i <= $A453)) Or ((i >= $C940) And (i <= $C944)) Then Result := 2
    //3劃
    Else If ((i >= $A454) And (i <= $A47E)) Or ((i >= $C945) And (i <= $C94C)) Then Result := 3
    //4劃
    Else If ((i >= $A4A1) And (i <= $A4FD)) Or ((i >= $C94D) And (i <= $C962)) Then Result := 4
    //5劃
    Else If ((i >= $A4FE) And (i <= $A5DF)) Or ((i >= $C963) And (i <= $C9AA)) Then Result := 5
    //6劃
    Else If ((i >= $A5E0) And (i <= $A6E9)) Or ((i >= $C9AB) And (i <= $CA59)) Then Result := 6
    //7劃
    Else If ((i >= $A6EA) And (i <= $A8C2)) Or ((i >= $CA5A) And (i <= $CBB0)) Then Result := 7
    //8劃
    Else If (i = $A260) Or ((i >= $A8C3) And (i <= $AB44)) Or ((i >= $CBB1) And (i <= $CDDC)) Then Result := 8
    //9劃
    Else If (i = $A259) Or (i = $F9DA) Or ((i >= $AB45) And (i <= $ADBB)) Or ((i >= $CDDD) And (i <= $D0C7)) Then Result := 9
    //10劃
    Else If (i = $A25A) Or ((i >= $ADBC) And (i <= $B0AD)) Or ((i >= $D0C8) And (i <= $D44A)) Then Result := 10
    //11劃
    Else If (i = $A25B) Or (i = $A25C) Or ((i >= $B0AE) And (i <= $B3C2)) Or ((i >= $D44B) And (i <= $D850)) Then Result := 11
    //12劃
    Else If (i = $F9DB) Or ((i >= $B3C3) And (i <= $B6C2)) Or ((i >= $D851) And (i <= $DCB0)) Then Result := 12
    //13劃
    Else If (i = $A25D) Or (i = $A25F) Or (i = $C6A1) Or (i = $F9D6) Or (i = $F9D8) Or ((i >= $B6C3) And (i <= $B9AB)) Or ((i >= $DCB1) And (i <= $E0EF)) Then Result := 13
    //14劃
    Else If (i = $F9DC) Or ((i >= $B9AC) And (i <= $BBF4)) Or ((i >= $E0F0) And (i <= $E4E5)) Then Result := 14
    //15劃
    Else If (i = $A261) Or ((i >= $BBF5) And (i <= $BEA6)) Or ((i >= $E4E6) And (i <= $E8F3)) Then Result := 15
    //16劃
    Else If (i = $A25E) Or (i = $F9D7) Or (i = $F9D9) Or ((i >= $BEA7) And (i <= $C074)) Or ((i >= $E8F4) And (i <= $ECB8)) Then Result := 16
    //17劃
    Else If ((i >= $C075) And (i <= $C24E)) Or ((i >= $ECB9) And (i <= $EFB6)) Then Result := 17
    //18劃
    Else If ((i >= $C24F) And (i <= $C35E)) Or ((i >= $EFB7) And (i <= $F1EA)) Then Result := 18
    //19劃
    Else If ((i >= $C35F) And (i <= $C454)) Or ((i >= $F1EB) And (i <= $F3FC)) Then Result := 19
    //20劃
    Else If ((i >= $C455) And (i <= $C4D6)) Or ((i >= $F3FD) And (i <= $F5BF)) Then Result := 20
    //21劃
    Else If ((i >= $C4D7) And (i <= $C56A)) Or ((i >= $F5C0) And (i <= $F6D5)) Then Result := 21
    //22劃
    Else If ((i >= $C56B) And (i <= $C5C7)) Or ((i >= $F6D6) And (i <= $F7CF)) Then Result := 22
    //23劃
    Else If ((i >= $C5C8) And (i <= $C5F0)) Or ((i >= $F7D0) And (i <= $F8A4)) Then Result := 23
    //24劃
    Else If ((i >= $C5F1) And (i <= $C654)) Or ((i >= $F8A5) And (i <= $F8ED)) Then Result := 24
    //25劃
    Else If ((i >= $C655) And (i <= $C664)) Or ((i >= $F8EE) And (i <= $F96A)) Then Result := 25
    //26劃
    Else If ((i >= $C665) And (i <= $C66B)) Or ((i >= $F96B) And (i <= $F9A1)) Then Result := 26
    //27劃
    Else If ((i >= $C66C) And (i <= $C675)) Or ((i >= $F9A2) And (i <= $F9B9)) Then Result := 27
    //28劃
    Else If ((i >= $C676) And (i <= $C678)) Or ((i >= $F9BA) And (i <= $F9C5)) Then Result := 28
    //29劃
    Else If ((i >= $C679) And (i <= $C67C)) Or ((i >= $F9C7) And (i <= $F9CB)) Then Result := 29
    //30劃
    Else If (i = $C67D) Or ((i >= $F9CC) And (i <= $F9CF)) Then Result := 30
    //30劃
    Else If (i = $C67D) Or ((i >= $F9CC) And (i <= $F9CF)) Then Result := 30
    //31劃
    Else If (i = $F9D0) Then Result := 31
    //32劃
    Else If (i = $C67E) Or (i = $F9D1) Then Result := 32
    //33劃
    Else If (i = $F9C6) Or (i = $F9D2) Then Result := 33
    //35劃
    Else If (i = $F9D3) Then Result := 35
    //36劃
    Else If (i = $F9D4) Then Result := 36
    //48劃
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
