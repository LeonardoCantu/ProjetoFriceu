unit FAG.RelatorioMovimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FAG.DetalharMovimento, FAG.Frame.Produto, frxExportCSV, frxExportPDF, frxExportText,
  frxClass, frxExportBaseDialog, frxExportRTF, frxDBSet;

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
    SpeedButton_limparConsulta: TSpeedButton;
    DataSource_consulta: TDataSource;
    FDMemTable_consulta: TFDMemTable;
    Panel_resultadoPesquisa: TPanel;
    exportWORD: TfrxRTFExport;
    exportTXT: TfrxSimpleTextExport;
    exportPDF: TfrxPDFExport;
    exportEXCEL: TfrxCSVExport;
    FDMemTable_consultamov_id: TIntegerField;
    FDMemTable_consultamov_data_movimento: TDateTimeField;
    FDMemTable_consultamov_tipo: TWideStringField;
    FDMemTable_consultalogin_usuario: TWideStringField;
    FDMemTable_consultaprod_desc: TWideStringField;
    FDMemTable_consultacat_desc: TWideStringField;
    frxDBDatasetExport: TfrxDBDataset;
    frxReportExport: TfrxReport;
    SpeedButton_exibirTodos: TSpeedButton;
    Label1: TLabel;
    RadioButtonSIM: TRadioButton;
    RadioButtonNAO: TRadioButton;
    procedure SpeedButton_sairClick(Sender: TObject);
    procedure SpeedButton_limparConsultaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton_filtrarClick(Sender: TObject);
    procedure SpeedButton_exibirTodosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton_exportarClick(Sender: TObject);
    procedure RadioButtonSIMClick(Sender: TObject);
    procedure RadioButtonNAOClick(Sender: TObject);


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
  if not FDMemTable_Consulta.IsEmpty  then
  begin
  FDMemTable_consulta.Open;
  FDMemTable_consulta.EmptyDataSet;
  FDMemTable_consulta.Close;
  FDMemTable_consulta.Open;
  end;
  Edit_codigo.Clear;
  Edit_produto.Clear;
  ComboBox_categoria.ItemIndex := 0;
  ComboBox_tipoMoviemento.ItemIndex := 0;
  DateTimePicker_Fim.DateTime := Now;
  Edit_codigo.SetFocus;

end;


procedure TForm_RelatorioMovimento.RadioButtonNAOClick(Sender: TObject);
begin
    DateTimePicker_Fim.Enabled := false;
    DateTimePicker_Ini.Enabled := false;

end;

procedure TForm_RelatorioMovimento.RadioButtonSIMClick(Sender: TObject);
begin
    DateTimePicker_Fim.Enabled := true;
    DateTimePicker_Ini.Enabled := true;

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
  ComboBox_tipoMoviemento.Items.Add('SAÍDA');
  ComboBox_tipoMoviemento.ItemIndex := 0;
  
  DBGrid_resultadoPesquisa.Columns[0].FieldName := 'mov_id';
  DBGrid_resultadoPesquisa.Columns[1].FieldName := 'prod_desc';
  DBGrid_resultadoPesquisa.Columns[2].FieldName := 'cat_desc';
  DBGrid_resultadoPesquisa.Columns[3].FieldName := 'mov_tipo';
  DBGrid_resultadoPesquisa.Columns[4].FieldName := 'mov_data_movimento';
  DBGrid_resultadoPesquisa.Columns[5].FieldName := 'usuario';

  RadioButtonSIM.Checked := true;
end;

procedure TForm_RelatorioMovimento.FormShow(Sender: TObject);
begin
  Edit_codigo.SetFocus;
end;


procedure TForm_RelatorioMovimento.SpeedButton_exibirTodosClick
  (Sender: TObject);
var
  sql: String;

begin
  sql := 'SELECT m.mov_id, m.mov_data_movimento,m.mov_tipo, m.usuario,' +
  ' p.prod_desc, c.cat_desc FROM movimento AS m ' +
  ' INNER JOIN item_movimento AS im ON m.mov_id = im.mov_id ' +
  ' INNER JOIN produto AS p ' + ' ON im.prod_id_produto = p.prod_id_produto '+
  ' INNER JOIN categoria AS c' +
  ' ON p.cat_id_categoria = c.cat_id_categoria WHERE 1 > 0 order by m.mov_id';

  DataModuleConexao.ExecSQL(sql, FDMemTable_consulta);

end;

procedure TForm_RelatorioMovimento.SpeedButton_exportarClick(Sender: TObject);
begin
  if FDMemTable_consulta.IsEmpty then
  begin
   Application.MessageBox ('Realize uma consulta para exportar!','Aviso',MB_OK+MB_ICONEXCLAMATION);
   exit
  end;
    frxReportExport.ShowReport();
end;

procedure TForm_RelatorioMovimento.buscaMovimentos;
var
  sql: String;
begin

  sql := 'SELECT m.mov_id, m.mov_data_movimento,m.mov_tipo, m.usuario,' +
    ' p.prod_desc, c.cat_desc FROM movimento AS m ' +
    ' INNER JOIN item_movimento AS im ON m.mov_id = im.mov_id ' +
    ' INNER JOIN produto AS p ' + ' ON im.prod_id_produto = p.prod_id_produto '+
    ' INNER JOIN categoria AS c' +
    ' ON p.cat_id_categoria = c.cat_id_categoria WHERE 1 > 0 ' ;

  if Trim(Edit_codigo.Text) <> EmptyStr then
  begin
    sql := sql + ' AND m.mov_id = ' + Edit_codigo.Text;
  end;

  if (DateTimePicker_Fim.Enabled = true) and (DateTimePicker_Ini.Enabled = true) then

  begin
    sql := sql + ' AND M.mov_data_movimento BETWEEN("' +
      FormatDateTime('yyyy-mm-dd', DateTimePicker_Ini.Date) + '")' + ' AND ("' +
      FormatDateTime('yyyy-mm-dd', DateTimePicker_Fim.Date) + '") ';
  end;

  if Trim(Edit_produto.Text) <> EmptyStr then
  begin
    sql := sql + ' AND (p.prod_desc LIKE "%' + Edit_produto.Text + '%")'
  end;

  if ComboBox_categoria.ItemIndex <> 0 then
  begin
    sql := sql + ' AND (c.cat_id_categoria = ' +
      ComboBox_categoria.ItemIndex.ToString + ')'
  end;

  if ComboBox_tipoMoviemento.ItemIndex <> 0 then
  begin
    sql := sql + ' AND (mov_tipo = "' + ComboBox_tipoMoviemento.Text + '")'
  end;

  sql := sql +  ' order by m.mov_id';

  DataModuleConexao.ExecSQL(sql, FDMemTable_consulta);
  if FDMemTable_consulta.IsEmpty then
  begin
     if (DateTimePicker_Ini.Enabled = true) and  (DateTimePicker_Fim.Date = DateTimePicker_Ini.Date) then
     begin
      Application.MessageBox ('Nenhum registro encontrado, verifique' +#13+ 'se a data está correta!','Aviso',MB_OK+MB_ICONEXCLAMATION);
     end else
     Application.MessageBox ('Nenhum registro encontrado!','Aviso',MB_OK+MB_ICONEXCLAMATION);
  end;

end;

procedure TForm_RelatorioMovimento.SpeedButton_filtrarClick(Sender: TObject);
begin
   if RadioButtonSIM.Enabled = true then
   begin
     if DateTimePicker_Ini.Date > DateTimePicker_Fim.Date then
     begin
       Application.MessageBox ('Data inicial maior que a final! Informe outra data.','Aviso',MB_OK+MB_ICONEXCLAMATION);
       DateTimePicker_Fim.Date := now;
       DateTimePicker_Ini.Date := now;
       DateTimePicker_Ini.SetFocus;
       exit;
     end;
   end
   else
   begin
    buscaMovimentos;
   end;

  if(Edit_codigo.Text = EmptyStr) and (Edit_produto.Text = EmptyStr)
   and (ComboBox_categoria.ItemIndex = 0) and (ComboBox_tipoMoviemento.ItemIndex = 0)
   and(RadioButtonSIM.Checked = false) and (RadioButtonNAO.Checked = true) then
   begin
    Application.MessageBox ('Preencha a consulta!','Aviso',MB_OK+MB_ICONEXCLAMATION);
   end
   else
   begin
    buscaMovimentos;
   end;
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
