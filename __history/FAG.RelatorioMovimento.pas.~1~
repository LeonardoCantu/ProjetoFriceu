unit FAG.RelatorioMovimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FAG.DetalharMovimento, FAG.Frame.Produto;

type
  TForm_RelatorioMovimento = class(TForm)
    Panel_relatorioMovimento: TPanel;
    GroupBox1: TGroupBox;
    Label_codigo: TLabel;
    Label_data_ate: TLabel;
    Label_produto: TLabel;
    Label_categoria: TLabel;
    Edit_codigo: TEdit;
    Edit_produto: TEdit;
    ComboBox_categoria: TComboBox;
    DateTimePicker_Fim: TDateTimePicker;
    Label_tituloForm: TLabel;
    DateTimePicker_Ini: TDateTimePicker;
    Label_data_de: TLabel;
    ComboBox_tipoMoviemento: TComboBox;
    Label_tipoMoviemento: TLabel;
    SpeedButton_filtrar: TSpeedButton;
    GroupBox2: TGroupBox;
    DBGrid_resultadoPesquisa: TDBGrid;
    SpeedButton_sair: TSpeedButton;
    SpeedButton_exportar: TSpeedButton;
    SpeedButton_detalharMov: TSpeedButton;
    SpeedButton_limparConsulta: TSpeedButton;
    SpeedButton_exibirTodos: TSpeedButton;
    DataSource_consulta: TDataSource;
    FDMemTable_consulta: TFDMemTable;
    Panel_resultadoPesquisa: TPanel;
    SaveDialog1: TSaveDialog;
    procedure SpeedButton_sairClick(Sender: TObject);
    procedure SpeedButton_limparConsultaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton_detalharMovClick(Sender: TObject);
    procedure SpeedButton_filtrarClick(Sender: TObject);
    procedure SpeedButton_exibirTodosClick(Sender: TObject);
    procedure DBGrid_resultadoPesquisaDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton_exportarClick(Sender: TObject);

  private
    procedure habilitaPesquisa;
    procedure limpaCampos;
    procedure alimentaCategoria;
    procedure buscaMovimentos;

  public

  end;

var
  Form_RelatorioMovimento: TForm_RelatorioMovimento;

implementation

{$R *.dfm}

Uses
  FAG.Menu, FAG.DataModule.Conexao, System.Math, ComObj;

procedure TForm_RelatorioMovimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
  Form_RelatorioMovimento := nil;
end;

procedure TForm_RelatorioMovimento.habilitaPesquisa;
begin
  Edit_codigo.Enabled := true;
  ComboBox_categoria.Enabled := true;
  ComboBox_tipoMoviemento.Enabled := true;
  DateTimePicker_Ini.Enabled := true;
  DateTimePicker_Fim.Enabled := true;
  DateTimePicker_Fim.DateTime := Now;
  DateTimePicker_Ini.DateTime := Now;
end;

procedure TForm_RelatorioMovimento.limpaCampos;
begin
  FDMemTable_consulta.Open;
  FDMemTable_consulta.EmptyDataSet;
  FDMemTable_consulta.Close;
  FDMemTable_consulta.Open;

  Edit_codigo.Clear;
  Edit_produto.Clear;
  ComboBox_categoria.ItemIndex := 0;
  ComboBox_tipoMoviemento.ItemIndex := 0;
  DateTimePicker_Fim.DateTime := Now;
  Edit_codigo.SetFocus;

end;

procedure TForm_RelatorioMovimento.alimentaCategoria;
var
  categoria: TFDMemTable;

begin
  categoria := TFDMemTable.Create(Self);

  try
    DataModuleConexao.ExecSQL('SELECT cat_desc FROM categoria', categoria);
    ComboBox_categoria.Items.Add('Todos');
    categoria.First;
    while not categoria.Eof do
    begin
      ComboBox_categoria.Items.Add(categoria.FieldByName('cat_desc').AsString);
      categoria.Next;
    end;
    ComboBox_categoria.ItemIndex := 0;
  finally
    FreeAndNil(categoria);
  end;
end;

procedure TForm_RelatorioMovimento.FormCreate(Sender: TObject);
begin
  alimentaCategoria;
  habilitaPesquisa;
  ComboBox_tipoMoviemento.Items.Add('TODOS');
  ComboBox_tipoMoviemento.Items.Add('ENTRADA');
  ComboBox_tipoMoviemento.Items.Add('SAIDA');
  ComboBox_tipoMoviemento.ItemIndex := 0;
  DBGrid_resultadoPesquisa.Columns[4].Visible := false;
  DBGrid_resultadoPesquisa.Columns[5].Visible := false;
  DBGrid_resultadoPesquisa.Columns[0].FieldName := 'mov_id';
  DBGrid_resultadoPesquisa.Columns[1].FieldName := 'mov_data_movimento';
  DBGrid_resultadoPesquisa.Columns[2].FieldName := 'mov_tipo';
  DBGrid_resultadoPesquisa.Columns[3].FieldName := 'login_usuario';
end;

procedure TForm_RelatorioMovimento.FormShow(Sender: TObject);
begin
  Edit_codigo.SetFocus;
end;

procedure TForm_RelatorioMovimento.SpeedButton_detalharMovClick
  (Sender: TObject);

begin
  if FDMemTable_consulta.IsEmpty = true then
  begin
    ShowMessage('Selecione um movimento');
    Edit_codigo.SetFocus;
    exit
  end;

  if not Assigned(Form_detalharMovimento) then
    Form_detalharMovimento := TForm_detalharMovimento.Create(Self);
  try
    Form_detalharMovimento.codigoConsulta := FDMemTable_consulta.FieldByName
      ('mov_id').AsString;

    Form_detalharMovimento.ShowModal;

  finally
    FreeAndNil(Form_detalharMovimento);
  end;

end;

procedure TForm_RelatorioMovimento.SpeedButton_exibirTodosClick
  (Sender: TObject);
var
  sql: String;
begin
   sql := 'SELECT m.mov_id, m.mov_data_movimento,m.mov_tipo,l.login_usuario,' +
    ' p.prod_desc, c.cat_desc FROM movimento AS m ' +
    ' INNER JOIN login AS l ON m.login_id = l.login_id ' +
    ' INNER JOIN item_movimento AS im ON m.mov_id = im.mov_id ' +
    ' INNER JOIN produto AS p ' + ' ON im.prod_id_produto = p.prod_id_produto '+
    ' INNER JOIN categoria AS c' +
    ' ON p.cat_id_categoria = c.cat_id_categoria WHERE 1 > 0 ';
    DataModuleConexao.ExecSQL(sql, FDMemTable_consulta);

end;

procedure TForm_RelatorioMovimento.SpeedButton_exportarClick(Sender: TObject);
var
Planilha :Variant;
Linha, cont : integer;
begin
  cont := FDMemTable_consulta.RecordCount;
  FDMemTable_consulta.Filtered := false;
  linha := 1;
  Planilha := CreateOleObject('Excel.application');
  Planilha.Caption := 'Exportar';
  Planilha.Visible := false;
  Planilha.workbooks.add(1);
  Planilha.cells[1,1]:= 'Código';
  Planilha.cells[1,2]:= 'Data';
  Planilha.cells[1,3]:= 'Tipo de Movimento';
  Planilha.cells[1,4]:= 'Usuário';
  linha := 2;
  FDMemTable_consulta.DisableControls;
  try

   while not FDMemTable_consulta.Eof do
   begin
     Planilha.cells[Linha,1] := FDMemTable_consulta.FieldByName('mov_id').Value;
     Planilha.cells[Linha,2] := FDMemTable_consulta.FieldByName('mov_data_movimento').Value;
     Planilha.cells[Linha,3] := FDMemTable_consulta.FieldByName('mov_tipo').AsString;
     Planilha.cells[Linha,4] := FDMemTable_consulta.FieldByName('login_usuario').AsString;
     Linha:= linha+1;
     FDMemTable_consulta.Next;
   end;
   Planilha.columns.autofit;
   try
    if SaveDialog1.Execute then
    begin
    Planilha.ActiveWorkbook.SaveAs(SaveDialog1.FileName+'.xlsx');
    Planilha.Visible := true;
    SaveDialog1.HistoryList.Clear;
    end;
   except
    Application.MessageBox ('Tente salvar o arquivo com outro nome','Erro',MB_OK+MB_ICONEXCLAMATION);
   end;


  finally
   FDMemTable_consulta.EnableControls;
   Planilha := Unassigned;

  end;


end;

procedure TForm_RelatorioMovimento.buscaMovimentos;
var
  sql: String;
begin

  sql := 'SELECT m.mov_id, m.mov_data_movimento,m.mov_tipo,l.login_usuario,' +
    ' p.prod_desc, c.cat_desc FROM movimento AS m ' +
    ' INNER JOIN login AS l ON m.login_id = l.login_id ' +
    ' INNER JOIN item_movimento AS im ON m.mov_id = im.mov_id ' +
    ' INNER JOIN produto AS p ' + ' ON im.prod_id_produto = p.prod_id_produto '+
    ' INNER JOIN categoria AS c' +
    ' ON p.cat_id_categoria = c.cat_id_categoria WHERE 1 > 0 ';

  if Trim(Edit_codigo.Text) <> EmptyStr then
  begin
    sql := sql + ' AND m.mov_id = ' + Edit_codigo.Text;
  end;

  if (DateTimePicker_Ini.Date <> 0) and (DateTimePicker_Fim.Date <> 0) then
  begin
    sql := sql + ' AND M.mov_data_movimento BETWEEN("' +
      FormatDateTime('yyyy-mm-dd', DateTimePicker_Ini.Date) + '")' + ' AND ("' +
      FormatDateTime('yyyy-mm-dd', DateTimePicker_Fim.Date) + '") ';
  end;

  if Trim(Edit_produto.Text) <> EmptyStr then
  begin
    sql := sql + ' AND (p.prod_desc LIKE "%' + Edit_produto.Text + '%")'
  end;

//  if FrProd_Filtro.Edit_codigoProduto.Text <> EmptyStr then
//  begin
//    sql := sql + ' AND (p.prod_id_produto = ' + FrProd_Filtro.FDMemTable_Produto.FieldByName('prod_id_produto').AsString + ')'
//  end;

  if ComboBox_categoria.ItemIndex <> 0 then
  begin
    sql := sql + ' AND (c.cat_id_categoria = ' +
      ComboBox_categoria.ItemIndex.ToString + ')'
  end;

  if ComboBox_tipoMoviemento.ItemIndex <> 0 then
  begin
    sql := sql + ' AND (mov_tipo = "' + ComboBox_tipoMoviemento.Text + '")'
  end;

  DataModuleConexao.ExecSQL(sql, FDMemTable_consulta);
  if FDMemTable_consulta.IsEmpty then
  begin
    ShowMessage('Nenhum movimento encontrado!');
  end;

end;

procedure TForm_RelatorioMovimento.DBGrid_resultadoPesquisaDblClick
  (Sender: TObject);
begin
  if FDMemTable_consulta.IsEmpty = true then
  begin
    ShowMessage('Selecione um movimento');
    Edit_codigo.SetFocus;
    exit
  end;

  if not Assigned(Form_detalharMovimento) then
    Form_detalharMovimento := TForm_detalharMovimento.Create(Self);
  try
    Form_detalharMovimento.codigoConsulta := FDMemTable_consulta.FieldByName
      ('mov_id').AsString;
    Form_detalharMovimento.ShowModal;

  finally
    FreeAndNil(Form_detalharMovimento);
  end;
end;

procedure TForm_RelatorioMovimento.SpeedButton_filtrarClick(Sender: TObject);
begin
   buscaMovimentos;
end;

procedure TForm_RelatorioMovimento.SpeedButton_limparConsultaClick
  (Sender: TObject);
begin
  limpaCampos;
end;

procedure TForm_RelatorioMovimento.SpeedButton_sairClick(Sender: TObject);
begin
  Form_RelatorioMovimento.Close;
end;

end.
