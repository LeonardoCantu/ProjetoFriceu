unit FAG.RelatorioUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, frxClass, frxExportBaseDialog, frxExportCSV, frxDBSet, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait, frxExportPDF, frxExportRTF, frxExportText;

type
  TForm_RelatorioUsuario = class(TForm)
    Panel_Principal: TPanel;
    Label_tituloForm: TLabel;
    SpeedButton_limparConsulta: TSpeedButton;
    SpeedButton_exportar: TSpeedButton;
    SpeedButton_sair: TSpeedButton;
    GroupBox_consulta: TGroupBox;
    Label_status: TLabel;
    SpeedButton_filtrar: TSpeedButton;
    ComboBox_Status: TComboBox;
    GroupBox_grid: TGroupBox;
    Panel_grid: TPanel;
    DBGrid_Pesquisa: TDBGrid;
    DataSource_Consulta: TDataSource;
    FDMemTable_Consulta: TFDMemTable;
    ComboBox_filtro: TComboBox;
    Label_filtro: TLabel;
    Label_pesquisa: TLabel;
    MaskEdit_pesquisa: TMaskEdit;
    frxReportExport: TfrxReport;
    FDMemTable_Consultapes_id_pessoa: TIntegerField;
    FDMemTable_Consultapes_nome: TWideStringField;
    FDMemTable_Consultapes_cpf: TWideStringField;
    FDMemTable_Consultapes_nascimento: TDateField;
    FDMemTable_Consultapes_email: TWideStringField;
    FDMemTable_Consultapes_celular: TWideStringField;
    frxDBDatasetExport: TfrxDBDataset;
    exportTXT: TfrxSimpleTextExport;
    exportWORD: TfrxRTFExport;
    exportPDF: TfrxPDFExport;
    exportEXCEL: TfrxCSVExport;
    SpeedButton_exibirTodos: TSpeedButton;
    FDMemTable_Consultapes_ativo: TIntegerField;
    FDMemTable_Consultapse_cnpj: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton_sairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton_limparConsultaClick(Sender: TObject);
    procedure SpeedButton_filtrarClick(Sender: TObject);
    procedure ComboBox_filtroSelect(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton_exibirTodosClick(Sender: TObject);
    procedure SpeedButton_exportarClick(Sender: TObject);
    procedure FDMemTable_Consultapes_ativoGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure FDMemTable_Consultapes_cpfGetText(Sender: TField; var Text: string; DisplayText: Boolean);



  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_RelatorioUsuario: TForm_RelatorioUsuario;

implementation

{$R *.dfm}
Uses
  FAG.Menu, FAG.DataModule.Conexao;


procedure TForm_RelatorioUsuario.ComboBox_filtroSelect(Sender: TObject);
begin

 if ComboBox_filtro.ItemIndex = 0 then
 begin
  MaskEdit_pesquisa.Clear;
  MaskEdit_pesquisa.EditMask := EmptyStr;
  MaskEdit_pesquisa.SetFocus;
 end;

 if ComboBox_filtro.ItemIndex = 1 then
 begin
  MaskEdit_pesquisa.Clear;
  MaskEdit_pesquisa.EditMask := EmptyStr;
  MaskEdit_pesquisa.SetFocus;
 end;

 if ComboBox_filtro.ItemIndex = 2 then
 begin
  MaskEdit_pesquisa.Clear;
  MaskEdit_pesquisa.EditMask := '999\.999\.999\-99;';
  MaskEdit_pesquisa.SetFocus;
 end;

 if ComboBox_filtro.ItemIndex = 3 then
 begin
  MaskEdit_pesquisa.Clear;
  MaskEdit_pesquisa.EditMask := '99\.999\.999\/9999\-99;';
  MaskEdit_pesquisa.SetFocus;
 end;


end;

procedure TForm_RelatorioUsuario.FDMemTable_Consultapes_ativoGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if (Sender as TField).AsString = '1' then
    text := 'ATIVO'
  else if (Sender as TField).AsString = '2' then
    begin
     text := 'INATIVO'
    end;
end;

procedure TForm_RelatorioUsuario.FDMemTable_Consultapes_cpfGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
 if (Sender as TField).AsString = '' then
    begin
     text := FDMemTable_Consultapse_cnpj.AsString;

    end else
    text := (Sender as TField).AsString;
end;

procedure TForm_RelatorioUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Release;
  Form_RelatorioUsuario := nil;
end;


procedure TForm_RelatorioUsuario.FormCreate(Sender: TObject);
begin


  ComboBox_filtro.Items.Add('CÓDIGO');
  ComboBox_filtro.Items.Add('NOME');
  ComboBox_filtro.Items.Add('CPF');
  ComboBox_filtro.Items.Add('CNPJ');
  ComboBox_filtro.ItemIndex := 1;

  ComboBox_Status.Items.Add('TODOS');
  ComboBox_Status.Items.Add('Ativo');
  ComboBox_Status.Items.Add('Inativo');
  ComboBox_Status.ItemIndex := 0;
  DBGrid_Pesquisa.Columns[0].FieldName := 'pes_id_pessoa';
  DBGrid_Pesquisa.Columns[1].FieldName := 'pes_nome';
  DBGrid_Pesquisa.Columns[2].FieldName := 'pes_cpf';
  DBGrid_Pesquisa.Columns[3].FieldName := 'pes_nascimento';
  DBGrid_Pesquisa.Columns[4].FieldName := 'pes_ativo';
  DBGrid_Pesquisa.Columns[5].FieldName := 'pes_celular';
  DBGrid_Pesquisa.Columns[6].FieldName := 'pes_email';


end;

procedure TForm_RelatorioUsuario.FormShow(Sender: TObject);
begin
MaskEdit_pesquisa.SetFocus;
end;


procedure TForm_RelatorioUsuario.SpeedButton_exibirTodosClick(Sender: TObject);
var
   sql: String;
begin
   sql := 'SELECT pes_id_pessoa, pes_nome, pes_cpf, pes_cnpj, pes_nascimento, pes_ativo, pes_email, pes_celular '
      +'FROM pessoa order by pes_id_pessoa ';
   DataModuleConexao.ExecSQL(sql, FDMemTable_Consulta);
end;

procedure TForm_RelatorioUsuario.SpeedButton_exportarClick(Sender: TObject);
begin
 // frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'relatorio.fr3');
  if FDMemTable_Consulta.IsEmpty then
  begin
   Application.MessageBox ('Realize uma pesquisa para exportar!','Aviso',MB_OK+MB_ICONEXCLAMATION);
   exit
  end;
    //frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'relatorioUsuario.fr3') ;
    frxReportExport.ShowReport();
end;

procedure TForm_RelatorioUsuario.SpeedButton_filtrarClick(Sender: TObject);
var
  sql: String;
begin
  if (MaskEdit_pesquisa.Text = EmptyStr) AND (ComboBox_Status.ItemIndex = 0) then
  begin
   Application.MessageBox ('Preencha a pesquisa!','Aviso',MB_OK+MB_ICONEXCLAMATION);
   MaskEdit_pesquisa.SetFocus;
   exit
  end;


  sql := 'SELECT pes_id_pessoa, pes_nome, pes_cpf, pes_cnpj, pes_nascimento, pes_email, pes_celular, pes_ativo FROM pessoa WHERE 1 > 0' ;

  if MaskEdit_pesquisa.Text <> EmptyStr then
  begin
    if ComboBox_filtro.ItemIndex = 0 then
    begin
      sql := sql + ' AND (pes_id_pessoa = "' + MaskEdit_pesquisa.Text + '")'
    end;
    if ComboBox_filtro.ItemIndex = 1 then
    begin
      sql := sql + ' AND (pes_nome LIKE "%' + MaskEdit_pesquisa.Text + '%")'
    end;
    if ComboBox_filtro.ItemIndex = 2 then
    begin
      sql := sql + ' AND (pes_cpf = "' + MaskEdit_pesquisa.Text + '")'
    end;
    if ComboBox_filtro.ItemIndex = 3 then
    begin
      sql := sql + ' AND (pes_cnpj = "' + MaskEdit_pesquisa.Text + '")'

    end;
  end;

  if ComboBox_Status.ItemIndex <> 0 then
  begin
    sql := sql + ' AND (pes_ativo = "' + ComboBox_Status.ItemIndex.ToString+ '")'
  end;


  DataModuleConexao.ExecSQL(sql, FDMemTable_Consulta);

  if FDMemTable_Consulta.IsEmpty then
  begin
    Application.MessageBox ('Nenhum registro encontrado!','Aviso',MB_OK+MB_ICONEXCLAMATION);
  end;
end;

procedure TForm_RelatorioUsuario.SpeedButton_limparConsultaClick(Sender: TObject);
begin
  if not FDMemTable_Consulta.IsEmpty  then
  begin
  FDMemTable_Consulta.Open;
  FDMemTable_Consulta.EmptyDataSet;
  FDMemTable_Consulta.Close;
  FDMemTable_Consulta.Open;
  end;
  ComboBox_Status.ItemIndex := 0;
  ComboBox_filtro.ItemIndex := 1;
  MaskEdit_pesquisa.Clear;
  MaskEdit_pesquisa.EditMask := EmptyStr;
end;

procedure TForm_RelatorioUsuario.SpeedButton_sairClick(Sender: TObject);
begin
 Form_RelatorioUsuario.Close;
end;

end.
