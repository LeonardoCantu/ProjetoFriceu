unit FAG.Movimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.Mask;

type
  TForm_Movimento = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Label_codigo: TLabel;
    Edit_codigo: TEdit;
    ComboBox_tipoMovimento: TComboBox;
    Label1: TLabel;
    Label_data: TLabel;
    DateTimePicker1: TDateTimePicker;
    SpeedButton_salvar: TSpeedButton;
    SpeedButton_sair: TSpeedButton;
    Label_tituloForm: TLabel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    ds_Itens: TDataSource;
    GroupBox2: TGroupBox;
    Panel3: TPanel;
    SpeedButton_Adicionar: TSpeedButton;
    SpeedButton_remover: TSpeedButton;
    Panel4: TPanel;
    Label2: TLabel;
    Image1: TImage;
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Edit_codigoProduto: TEdit;
    Edit_descricao: TEdit;
    Edit_categoria: TEdit;
    Edit_quantidade: TEdit;
    FDMemTable1: TFDMemTable;
    FDMemTable2: TFDMemTable;
    Table_Itens: TFDMemTable;
    Table_Itensprod_id_produto: TIntegerField;
    Table_Itensprod_desc: TWideStringField;
    Table_Itensprod_quantidade: TIntegerField;
    Table_Itensmov_tipo: TStringField;
    Table_Itensun_medida_desc: TStringField;
    FDMemTable3: TFDMemTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton_removerClick(Sender: TObject);
    procedure SpeedButton_AdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton_salvarClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure SpeedButton_sairClick(Sender: TObject);
    procedure Edit_codigoProdutoExit(Sender: TObject);
  private
    unidadeMedida: String;
    function addItem: Boolean;
    function validaItem: Boolean;
    function delItem: Boolean;
    function saveLancamento: Boolean;
    procedure limpar;
    procedure alterarQuantidade;
  public
    { Public declarations }
  end;

var
  Form_Movimento: TForm_Movimento;

implementation

uses
  FAG.DataModule.Conexao, FAG.Produtos, FAG.Menu;

{$R *.dfm}

function TForm_Movimento.addItem: Boolean;
begin
  if Table_Itens.Locate('prod_id_produto', Edit_codigoProduto.Text, []) then
    Table_Itens.Edit
  else
    Table_Itens.Append;

  Table_Itens.FieldByName('prod_id_produto').AsInteger :=
    StrToInt(Edit_codigoProduto.Text);

  Table_Itens.FieldByName('prod_desc').AsString := Edit_descricao.Text;

  Table_Itens.FieldByName('un_medida_sigla').AsString;

  Table_Itens.FieldByName('mov_tipo').AsString := ComboBox_tipoMovimento.Text;

  Table_Itens.FieldByName('prod_quantidade').AsInteger :=
    StrToInt(Edit_quantidade.Text);

  Table_Itens.FieldByName('un_medida_sigla').AsString := unidadeMedida;

  Table_Itens.Post;

end;

procedure TForm_Movimento.alterarQuantidade;
var
  buscar: integer;

begin

  DataModuleConexao.ExecSQL
    ('SELECT prod_quantidade FROM produto WHERE prod_id_produto = ' +
    Table_Itens.FieldByName('prod_id_produto').AsString, FDMemTable3);

  if Table_Itens.FieldByName('mov_tipo').AsString = 'ENTRADA' then
  begin
    buscar := Table_Itens.FieldByName('prod_quantidade').AsInteger +
      FDMemTable3.FieldByName('prod_quantidade').AsInteger;

    DataModuleConexao.ExecSQL('UPDATE produto SET prod_quantidade = ' +
      IntToStr(buscar) + ' WHERE prod_id_produto = ' + Table_Itens.FieldByName
      ('prod_id_produto').AsString);
  end
  else if Table_Itens.FieldByName('mov_tipo').AsString = 'SAÍDA' then
  begin
    buscar := (FDMemTable3.FieldByName('prod_quantidade').AsInteger) -
      (Table_Itens.FieldByName('prod_quantidade').AsInteger);

    if buscar < 0 then
    begin
      Application.MessageBox('O produto ficou com a quantidade negativa, favor verificar o estoque', 'Quantidade inválida',
        MB_ICONWARNING + MB_TASKMODAL + MB_OK);
      Abort;
    end
    else
    begin

      DataModuleConexao.ExecSQL('UPDATE produto SET prod_quantidade = ' +
        IntToStr(buscar) + ' WHERE prod_id_produto = ' + Table_Itens.FieldByName
        ('prod_id_produto').AsString);

    end;
  end;

end;

function TForm_Movimento.delItem: Boolean;
begin
  if Table_Itens.IsEmpty then
  begin
    Application.MessageBox('Não existe itens para remover',
      'Lançamento em branco', MB_ICONWARNING + MB_TASKMODAL + MB_OK);
  end
  else
  begin
    if Application.MessageBox('Atenção, deseja remover o item do lançamento?',
      'Remoção do item', MB_ICONWARNING + MB_TASKMODAL + MB_YESNO) = ID_YES then
    begin
      Table_Itens.Delete;
    end;
  end;
end;

procedure TForm_Movimento.Edit_codigoProdutoExit(Sender: TObject);
begin
  DataModuleConexao.ExecSQL
    ('SELECT prod_desc, cat_desc, un_medida_sigla FROM produto INNER JOIN categoria USING (cat_id_categoria) INNER JOIN un_medida USING (un_medida_id) WHERE prod_id_produto = "'
    + Edit_codigoProduto.Text + '"', FDMemTable2);

  if FDMemTable2.IsEmpty then
  begin
    Application.MessageBox('Esse código não existe', 'Produto não cadastrado',
      MB_ICONWARNING + MB_TASKMODAL + MB_OK);
  end;

  Edit_descricao.Text := FDMemTable2.FieldByName('prod_desc').AsString;
  Edit_categoria.Text := FDMemTable2.FieldByName('cat_desc').AsString;
  unidadeMedida := FDMemTable2.FieldByName('un_medida_sigla').AsString;

end;

procedure TForm_Movimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
  Release;
  Form_Movimento := nil;
end;

procedure TForm_Movimento.FormCreate(Sender: TObject);
var
  codigo: String;
begin
  Table_Itens.CreateDataSet;
  DateTimePicker1.DateTime := Now;
  DataModuleConexao.ExecSQL('SELECT MAX(mov_id)+1 FROM movimento', FDMemTable1);
  codigo := FDMemTable1.FieldByName('MAX(mov_id)+1').AsString;
  Edit_codigo.Text := codigo;

  ComboBox_tipoMovimento.Items.Add('ENTRADA');
  ComboBox_tipoMovimento.Items.Add('SAÍDA');
  ComboBox_tipoMovimento.ItemIndex := 0;
end;

procedure TForm_Movimento.FormShow(Sender: TObject);
begin

  Edit_codigo.Enabled := False;
  Edit_descricao.Enabled := False;
  Edit_categoria.Enabled := False;

end;

procedure TForm_Movimento.Image1Click(Sender: TObject);
begin
  try
    Form_Produtos := TForm_Produtos.Create(nil);

    if Form_Produtos.ShowModal = mrOk then
    begin
      Edit_codigoProduto.Text := Form_Produtos.Mem_Produtos.FieldByName
        ('prod_id_produto').AsString;
      Edit_descricao.Text := Form_Produtos.Mem_Produtos.FieldByName
        ('prod_desc').AsString;
      Edit_categoria.Text := Form_Produtos.Mem_Produtos.FieldByName
        ('cat_desc').AsString;
      unidadeMedida := Form_Produtos.Mem_Produtos.FieldByName
        ('un_medida_sigla').AsString;
    end;
  finally
    Form_Produtos.Release;
  end;
end;

procedure TForm_Movimento.limpar;
begin
  Edit_codigoProduto.Clear;
  Edit_descricao.Clear;
  Edit_categoria.Clear;
  Edit_quantidade.Clear;
  Table_Itens.EmptyDataSet;
  DataModuleConexao.ExecSQL('SELECT MAX(mov_id)+1 FROM movimento', FDMemTable1);
  Edit_codigo.Text := FDMemTable1.FieldByName('MAX(mov_id)+1').AsString;;
end;

function TForm_Movimento.saveLancamento: Boolean;
var
  sql: String;
  sql2: String;
  codigo: String;

begin

  if Table_Itens.IsEmpty then
  begin
    Application.MessageBox
      ('Você precisa primeiro realizar um lançamento para salvar',
      'Lançamento em branco', MB_ICONINFORMATION + MB_TASKMODAL + MB_OK);
  end
  else
  begin

    Table_Itens.First;
    while not Table_Itens.Eof do
    begin
      DataModuleConexao.ExecSQL('SELECT MAX(mov_id)+1 FROM movimento',
        FDMemTable1);

      codigo := FDMemTable1.FieldByName('MAX(mov_id)+1').AsString;

      sql := 'INSERT INTO movimento (mov_tipo, usuario, mov_data_movimento) VALUES ("'
        + Table_Itens.FieldByName('mov_tipo').AsString + ' ","' +
        Form_Menu.usuarioLogado + '", now())';

      sql2 := 'INSERT INTO item_movimento (mov_id, prod_id_produto, mov_quantidade) VALUES ('
        + codigo + ',' + Table_Itens.FieldByName('prod_id_produto').AsString +
        ',' + Table_Itens.FieldByName('prod_quantidade').AsString + ')';

      alterarQuantidade;
      DataModuleConexao.ExecSQL(sql);
      DataModuleConexao.ExecSQL(sql2);

      Table_Itens.Next;
    end;

    Application.MessageBox('Movimento realizado com sucesso', 'Sucesso',
      MB_ICONINFORMATION + MB_TASKMODAL + MB_OK);

    limpar;
  end;
end;

procedure TForm_Movimento.SpeedButton_AdicionarClick(Sender: TObject);
begin
  if validaItem then
    addItem;
end;

procedure TForm_Movimento.SpeedButton_removerClick(Sender: TObject);
begin
  delItem;
end;

procedure TForm_Movimento.SpeedButton_sairClick(Sender: TObject);
begin
  Form_Movimento.Close;
end;

procedure TForm_Movimento.SpeedButton_salvarClick(Sender: TObject);
begin
  saveLancamento;
end;

function TForm_Movimento.validaItem: Boolean;
begin
  Result := False;
  if Edit_codigoProduto.Text = EmptyStr then
  begin
    Application.MessageBox('Código do produto não informado', 'Campo em branco',
      MB_ICONWARNING + MB_TASKMODAL + MB_OK);
    Edit_codigoProduto.SetFocus;
  end
  else if Edit_descricao.Text = '' then
  begin
    Application.MessageBox('Descrição do produto não informada',
      'Campo em branco', MB_ICONWARNING + MB_TASKMODAL + MB_OK);
  end
  else if Edit_categoria.Text = '' then
  begin
    Application.MessageBox('Categoria do produto não informada',
      'Campo em branco', MB_ICONWARNING + MB_TASKMODAL + MB_OK);
  end
  else if Edit_quantidade.Text = '' then
  begin
    Application.MessageBox('Quantidade do produto não informada',
      'Campo em branco', MB_ICONWARNING + MB_TASKMODAL + MB_OK);
    Edit_quantidade.SetFocus;
  end
  else if Edit_quantidade.Text = '0' then
  begin
    Application.MessageBox('Você não pode informar o zero como quantidade',
      'Número inválido', MB_ICONWARNING + MB_TASKMODAL + MB_OK);
    Edit_quantidade.SetFocus;
  end
  else
  begin
    Result := True;
  end;
end;

end.
