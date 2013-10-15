unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, BarChart, LCLIntf;

type

  { TForm1 }

  TForm1 = class(TForm)
    BarChart1: TBarChart;
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

    procedure BubbleSort();

    procedure QuickSort(links, rechts : Integer);
    function Teile(links, rechts : Integer):Integer;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  zahlen : Array [0..9] of Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var i : Integer;
begin
  //zufallsgenerator initialisieren
  randomize;
  //ListBox und BarChart leeren
  ListBox1.Clear;
  BarChart1.Clear;
  //for-schleife zum erzeugen der zufallszahlen
  //und das zuweisen in das array "zahlen"
  for i := 0 to 9 do
  begin
    //zufallszahl wird erzeugt
    zahlen[i]:=random(100);
    //in ListBox1 wird die zufallszahl eingefügt
    ListBox1.Items.Add(IntToStr(zahlen[i]));
    //in BarChart wird balken erzeugt
    BarChart1.AddBar('',zahlen[i],clBlack);
    //BarChart wird aktualisiert
    BarChart1.Update;
    //250 ms warten
    sleep(250);
  end;
end;

//wird aufgerufen sobald "sortieren"-button gedrückt wird
procedure TForm1.Button2Click(Sender: TObject);
var i, start, stop : Integer;
begin
  //listBox2 wird geleert
  ListBox2.Clear;
  //fallunterscheidung
  //je nachdem welcher sortieralgorithmus in der Radiogroup ausgewählt ist
  case RadioGroup1.ItemIndex of
  0:
    begin
      //BubbleSort Algorithmus wird in Gang gesetzt
      start := GetTickCount;
      BubbleSort();
      stop := GetTickCount;
      //danach wird das sortierte array in ListBox2 ausgegeben
      ListBox2.Items.Add('BubbleSort:');
      for i := 0 to 9 do
      begin
      ListBox2.Items.Add(IntToStr(zahlen[i]));
      end;
      ListBox2.Items.Add('In ' + IntToStr(stop-start)+'ms');
    end;
  1: {QuickSort Algorithmus wird in Gang gesetzt}
    begin
      start := GetTickCount;
      QuickSort(0,9);
      stop := GetTickCount;
      for i := 0 to 9 do
      begin
      ListBox2.Items.Add(IntToStr(zahlen[i]));
      end;
      ListBox2.Items.Add('In ' + IntToStr(stop-start)+'ms');
    end;
  end;
end;


//Bubble
procedure TForm1.BubbleSort();
var i, j, swap : Integer;
begin
  //erste for-Schleife wird in gang gesetzt
  //gibt die größt mögliche anzahl der durchgänge
  for i := 0 to 100 do
  begin
    //zweite for-Schleife wird in gang gesetzt
    //um einzeln die werte des arrays durch zu gehen
    for j := 0 to 8 do
    begin
      //aktuelle werte werden in BarChart blau eingefärbt
      BarChart1.GetBar(j).Color:=clBlue;
      BarChart1.GetBar(j+1).Color:=clBlue;
      BarChart1.Update;
      sleep(250);
      //wenn aktuelle zahl ist größer als nachfolger
      if zahlen[j] > zahlen[j+1] then
      //dann
      begin
        //beide werte werden in BarChart rot eingefärbt
        BarChart1.GetBar(j).Color:=clRed;
        BarChart1.GetBar(j+1).Color:=clRed;
        BarChart1.Update;
        sleep(250);
        //werte werden getauscht
        swap := zahlen[j];
        zahlen[j] := zahlen[j+1];
        zahlen[j+1] := swap;
        //auch in BarChart
        BarChart1.GetBar(j).Value:=zahlen[j];
        BarChart1.GetBar(j+1).Value:=zahlen[j+1];
        BarChart1.Update;
        sleep(250);
      end
      //sonst
      else
      begin
        //werte in BarChart werden grün eingefärbt
        BarChart1.GetBar(j).Color:=clGreen;
        BarChart1.GetBar(j+1).Color:=clGreen;
        BarChart1.Update;
        sleep(250);
      end;
      //werte in BarChart werden wieder schwarz gefärbt
      BarChart1.GetBar(j).Color:=clBlack;
      BarChart1.GetBar(j+1).Color:=clBlack;
      BarChart1.Update;
      sleep(1000);
    end;
    //prüfen, ob array geordnet ist, wenn ja dann abbruch des BubbleSort
    //sonst weiterer durchgang
    if (zahlen[0] <= zahlen[1]) AND (zahlen[1] <= zahlen[2]) AND (zahlen[2] <= zahlen[3]) AND (zahlen[3] <= zahlen[4]) AND (zahlen[4] <= zahlen[5]) AND (zahlen[5] <= zahlen[6]) AND (zahlen[6] <= zahlen[7]) AND (zahlen[7] <= zahlen[8]) AND (zahlen[8] <= zahlen[9]) then exit;
  end;

end;



//QuickSort-Algorithmus
procedure TForm1.QuickSort(links, rechts : Integer);
var  k, teiler : Integer;
begin
  if links < rechts then
  begin
    teiler := Teile(links, rechts);
    QuickSort(links, teiler-1);
    QuickSort(teiler+1, rechts);
  end;
end;

function TForm1.Teile(links, rechts : Integer):Integer;
var pivot, i, j, k, swap : Integer;
begin
  i := links;
  j := rechts;
  pivot := zahlen[rechts];
  while i < j do
  begin
    while (zahlen[i] <= pivot) AND (i < rechts)
      do
      begin
      BarChart1.GetBar(i).Color:=clGreen;
      BarChart1.Update;
      sleep(250);
      i := i+1;
      BarChart1.GetBar(i).Color:=clGreen;
      BarChart1.Update;
      sleep(250);
      end;
    while (zahlen[j] >= pivot) AND (j > links) do
    begin
      BarChart1.GetBar(j).Color:=clGreen;
      BarChart1.Update;
      sleep(250);
      j := j-1;
      BarChart1.GetBar(j).Color:=clGreen;
      BarChart1.Update;
      sleep(250);
    end;
     if i < j then
     begin
       BarChart1.GetBar(i).Color:=clRed;
       BarChart1.GetBar(j).Color:=clRed;
       BarChart1.Update;
       sleep(250);
       //tauschen
       swap := zahlen[i];
       zahlen[i] := zahlen[j];
       zahlen[j] := swap;
       BarChart1.GetBar(i).Value:=zahlen[i];
       BarChart1.GetBar(j).Value:=zahlen[j];
       BarChart1.Update;
       sleep(250);

     end;
 end;
  for k := 0 to 9 do
  begin
    BarChart1.GetBar(k).Color:=clBlack;
  end;
  if zahlen[i] > pivot then
    begin
      BarChart1.GetBar(i).Color:=clRed;
      BarChart1.GetBar(rechts).Color:=clRed;
      BarChart1.Update;
      sleep(250);
      //tauschen
      swap := zahlen[i];
      zahlen[i] := zahlen[rechts];
      zahlen[rechts] := swap;
      BarChart1.GetBar(i).Value:=zahlen[i];
      BarChart1.GetBar(rechts).Value:=zahlen[rechts];
      BarChart1.Update;
      sleep(250);
      BarChart1.GetBar(i).Color:=clBlack;
      BarChart1.GetBar(rechts).Color:=clBlack;
    end;
    Teile := i;

end;

end.

