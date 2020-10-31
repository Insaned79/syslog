unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, DBCtrls, DBGrids, DateTimePicker;

type

  { Tfilt }

  Tfilt = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    CheckBox1: TCheckBox;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    dblist1: TDBLookupListBox;
    dblist2: TDBLookupListBox;
    dblist3: TDBLookupListBox;
    DTP1: TDateTimePicker;
    DTP2: TDateTimePicker;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    hostqueryhost: TStringField;
    Label1: TLabel;
    Label2: TLabel;
    levelquerylevel: TStringField;
    Memo1: TListBox;
    Memo2: TListBox;
    Memo3: TListBox;
    Memo4: TListBox;
    Memo5: TListBox;
    Panel1: TPanel;
    hostquery: TSQLQuery;
    progquery: TSQLQuery;
    progqueryprogram: TStringField;
    levelquery: TSQLQuery;
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure DBListBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Memo3Click(Sender: TObject);
  private

  public

  end;

var
  filt: Tfilt;

implementation

{$R *.lfm}
uses main;

{ Tfilt }

procedure Tfilt.BitBtn2Click(Sender: TObject);
var
  query,datefrom,dateto:string;
  i: integer;
begin
//select date,time,host,priority,level,facility,program,msg   from logs  order by seq desc limit 1000
query:='select date,time,host,priority,level,facility,program,msg   from logs ';


//Фильтр по дате
if checkbox1.Checked then
   begin
        query:=query+' where (date=CURRENT_DATE)'
   end
else
   begin
        datefrom:=FormatDateTime('yyyy-MM-dd', DTP1.Date);
        dateto:=FormatDateTime('yyyy-MM-dd', DTP2.Date);
        query:=query+' where (date between "' + datefrom + '"';
        query:=query+' and "' + dateto + '")';

   end;

//Фильтр по хосту
if memo1.Items.Count > 0 then
   begin
        query := query + ' and (';
        for i:=0 to memo1.Items.Count-1 do
        begin
             if i=0 then
                begin
                query:=query+'(host="' + memo1.Items[i] + '")';
                end
             else
                begin
                 query := query + ' or (host="' + memo1.Items[i] + '")';
                end;
        end;
        query := query + ' )';
   end;


//Фильтр по программе
if memo2.Items.Count > 0 then
   begin
        query := query + ' and (';
        for i:=0 to memo2.Items.Count-1 do
        begin
             if i=0 then
                begin
                query:=query+'(program="' + memo2.Items[i] + '")';
                end
             else
                begin
                 query := query + ' or (program="' + memo2.Items[i] + '")';
                end;
        end;
        query := query + ' )';
   end;


//Фильтр по уровню
if memo3.Items.Count > 0 then
   begin
        query := query + ' and (';
        for i:=0 to memo3.Items.Count-1 do
        begin
             if i=0 then
                begin
                query:=query+'(level="' + memo3.Items[i] + '")';
                end
             else
                begin
                 query := query + ' or (level="' + memo3.Items[i] + '")';
                end;
        end;
        query := query + ' )';
   end;


//Фильтр по тексту
if memo4.Items.Count > 0 then
   begin
        query := query + ' and (';
        for i:=0 to memo4.Items.Count-1 do
        begin
             if i=0 then
                begin
                query:=query+'(MATCH (msg) AGAINST ("' + AnsiUpperCase(memo4.Items[i]) + '" IN BOOLEAN MODE))';
                end
             else
                begin
                 query := query + ' or (MATCH (msg) AGAINST ("' + AnsiUpperCase(memo4.Items[i]) + '" IN BOOLEAN MODE)';
                end;
        end;
        query := query + ' )';
   end;


//Исключение подстроки
if memo5.Items.Count > 0 then
   begin
        query := query + ' and (';
        for i:=0 to memo5.Items.Count-1 do
        begin
             if i=0 then
                begin
                query:=query+'(upper(msg) not like "%' + AnsiUpperCase(memo5.Items[i]) + '%")';
                end
             else
                begin
                 query := query + 'and (upper(msg) not like "%' + AnsiUpperCase(memo5.Items[i]) + '%")';
                end;
        end;
        query := query + ' )';
   end;

query:=query + ' order by seq desc limit 1000';
//showmessage(query);
mainform.query.SQL.Clear;
mainform.query.SQL.Add(query);

end;

procedure Tfilt.BitBtn3Click(Sender: TObject);
begin
  memo1.Items.Clear;
end;

procedure Tfilt.BitBtn4Click(Sender: TObject);
begin
  if dblist2.GetSelectedText <> '' then  memo2.Items.Add(dblist2.GetSelectedText);
end;

procedure Tfilt.BitBtn5Click(Sender: TObject);
begin
  memo2.Items.Clear;
end;

procedure Tfilt.BitBtn6Click(Sender: TObject);
begin
     if dblist3.GetSelectedText <> '' then  memo3.Items.Add(dblist3.GetSelectedText);
end;

procedure Tfilt.BitBtn7Click(Sender: TObject);
begin
   memo3.Items.Clear;
end;

procedure Tfilt.BitBtn8Click(Sender: TObject);
begin
     if edit1.text <> '' then
     begin
          memo4.Items.Add(edit1.text);
          edit1.text:='';

     end;
end;

procedure Tfilt.BitBtn9Click(Sender: TObject);
begin
     memo4.Items.Clear;
end;

procedure Tfilt.BitBtn1Click(Sender: TObject);
begin
  if dblist1.GetSelectedText <> '' then  memo1.Items.Add(dblist1.GetSelectedText);
end;

procedure Tfilt.BitBtn10Click(Sender: TObject);
begin
       if edit2.text <> '' then
     begin
          memo5.Items.Add(edit2.text);
          edit2.text:='';

     end;
end;

procedure Tfilt.BitBtn11Click(Sender: TObject);
begin
  memo5.Items.Clear;
end;

procedure Tfilt.CheckBox1Change(Sender: TObject);
begin
  DTP1.Enabled:= not(CheckBox1.Checked);
  DTP2.Enabled:= not(CheckBox1.Checked);
end;

procedure Tfilt.DBListBox1Click(Sender: TObject);
begin

end;

procedure Tfilt.FormShow(Sender: TObject);
begin
  hostquery.Active:=False;
  hostquery.Active:=True;
  progquery.Active:=False;
  progquery.Active:=True;
  levelquery.Active:=False;
  levelquery.Active:=True;

end;

procedure Tfilt.Memo3Click(Sender: TObject);
begin

end;

end.

