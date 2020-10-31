unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql57conn, mysql56conn, SQLDB, DB, Forms, Controls,
  Graphics, Dialogs, Menus, DBGrids, ExtCtrls, unit1, INIFiles, FileUtil, Grids,
  Buttons, DBCtrls, unit2;

type

  { TMainform }

  MemoDifier = class
    public
      procedure DBGridOnGetText(Sender: TField; var aText: string;
        DisplayText: boolean);
    end;

  TMainform = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBMemo1: TDBMemo;
    MainMenu: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    connect: TMySQL57Connection;
    Panel1: TPanel;
    Panel2: TPanel;
    query: TSQLQuery;
    querydate: TDateField;
    queryfacility: TStringField;
    queryhost: TStringField;
    querylevel: TStringField;
    querymsg: TStringField;
    querypriority: TStringField;
    queryprogram: TStringField;
    querytime: TTimeField;
    SQLTransaction1: TSQLTransaction;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure querymsgGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
  private

  public

  end;

var
  Mainform: TMainform;

implementation

{$R *.lfm}

{ TMainform }

procedure MemoDifier.DBGridOnGetText(Sender: TField; var aText: string;
  DisplayText: boolean);
begin
 // if (DisplayText) then
 //   aText := Sender.AsString;
end;


procedure TMainform.MenuItem1Click(Sender: TObject);
begin

end;

procedure TMainform.FormCreate(Sender: TObject);
var
   inifile: string;
   IniF: TINIFile;
begin
    inifile:=ExtractFileDir(paramstr(0));
  inifile:=inifile+'/settings.ini';
    if FileExists(inifile) then
  begin
      Inif := TINIFile.Create(inifile);
      connect.HostName := Inif.ReadString('Main','Host','');
      connect.DataBaseName  := Inif.ReadString('Main','DataBase','');
      connect.UserName := Inif.ReadString('Main','UserName','');
      connect.Password := Inif.ReadString('Main','Password','');
      query.SQL.Clear;
      query.SQL.Add(Inif.ReadString('Main','Query','select date,time,host,priority,level,facility,program, msg from logs order by seq desc;'));
      //SQL. string := Inif.ReadString('Main','Query','');
      Inif.Destroy;
 //     try
        connect.Connected := True;
        query.Active:= True;
//      except
//        query.Active:= False;
//        connect.Connected := False;

//      end;
  end;
end;

procedure TMainform.FormResize(Sender: TObject);
begin
  //
      dbgrid1.Columns[5].Width:=mainform.Width-480;
end;

procedure TMainform.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
var
  MemoFieldReveal: MemoDifier;
begin
   if (DataCol = 1) then
   begin
     try
       //DBGrid1.Columns.Items[0].Field.OnGetText := @MemoFieldReveal.DBGridOnGetText;
       //DBGrid1.Columns.Items[1].Field.OnGetText := @MemoFieldReveal.DBGridOnGetText;
       //DBGrid1.Columns.Items[2].Field.OnGetText := @MemoFieldReveal.DBGridOnGetText;
       //DBGrid1.Columns.Items[3].Field.OnGetText := @MemoFieldReveal.DBGridOnGetText;
       //DBGrid1.Columns.Items[4].Field.OnGetText := @MemoFieldReveal.DBGridOnGetText;


     except

       On E: Exception do
       begin
         ShowMessage('Exception caught : ' + E.Message);
       end;
     end;
   end;
end;

procedure TMainform.BitBtn1Click(Sender: TObject);
begin
  if query.Active then query.Refresh;
end;

procedure TMainform.BitBtn2Click(Sender: TObject);
begin
  if filt.showmodal=mrok then query.Refresh;

end;

procedure TMainform.MenuItem2Click(Sender: TObject);
var
  r: TModalresult;
  inifile: string;
  IniF: TINIFile;
begin
  r := settings.showmodal();
  if r = MrOk then
  begin
  query.Active:= False;
  connect.Connected := False;


     inifile:=ExtractFileDir(paramstr(0));
     inifile:=inifile+'/settings.ini';
     if FileExists(inifile) then
      begin
         Inif := TINIFile.Create(inifile);
         connect.HostName := Inif.ReadString('Main','Host','');
         connect.DataBaseName  := Inif.ReadString('Main','DataBase','');
         connect.UserName := Inif.ReadString('Main','UserName','');
         connect.Password := Inif.ReadString('Main','Password','');
         Inif.Destroy;
      try
        connect.Connected := True;
        query.Active:= True;
      finally
      end;
  end;
  end;


end;

procedure TMainform.MenuItem4Click(Sender: TObject);
begin
  halt(0);
end;

procedure TMainform.Panel1Resize(Sender: TObject);
begin

end;

procedure TMainform.querymsgGetText(Sender: TField; var aText: string;
  DisplayText: Boolean);
begin
  aText := Sender.AsString;
  DisplayText:=true;
end;

end.

