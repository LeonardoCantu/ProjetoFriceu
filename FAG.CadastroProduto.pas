unit FAG.CadastroProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ComCtrls, FAG.Frame.Generico,
  FAG.Frame.UnMedida;

type
  TForm_CadastroProduto = class(TForm)
    Panel_cadastroProduto: TPanel;
    Edit_codigo: TEdit;
    Label_tituloForm: TLabel;
    GroupBox1: TGroupBox;
    Label_codigo: TLabel;
    Label_status: TLabel;
    ComboBox_status: TComboBox;
    DateTimePicker1: TDateTimePicker;
    Label_data: TLabel;
    Edit_descricao: TEdit;
    Label_descricao: TLabel;
    SpeedButton_pesquisar: TSpeedButton;
    SpeedButton_sair: TSpeedButton;
    SpeedButton_cancelar: TSpeedButton;
    Label_valor: TLabel;
    Frame_Categoria: TFrame_Generico;
    Edit_valor: TEdit;
    FDMemTable1: TFDMemTable;
    Frame_UnMedida: TFrame_Generico;
    GroupBox2: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn_categoria: TBitBtn;
    BitBtn_unMedida: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton_sairClick(Sender: TObject);
    procedure SpeedButton_cancelarClick(Sender: TObject);
    procedure SpeedButton_unMedidaClick(Sender: TObject);
    procedure Frame_CategoriaExit(Sender: TObject);
    procedure Edit_valorExit(Sender: TObject);
    procedure Edit_valorKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_valorChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton_pesquisarClick(Sender: TObject);
    procedure SpeedButton_salvarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn_unMedidaClick(Sender: TObject);
    procedure BitBtn_categoriaClick(Sender: TObject);
    procedure Frame_CategoriaComboBox_InformacaoExit(Sender: TObject);
    procedure Frame_UnMedidaComboBox_InformacaoExit(Sender: TObject);
  private
    { Private declarations }
    function getUltimoID: String;
    function cancelar: Boolean;
    function gravar: Boolean;
    function validarCampos: Boolean;
    procedure loadTela(id: string);
    function existe_produto(codigo: string): Boolean;
    function carregaCategoria: Boolean;
    function carregaUnMedida: Boolean;
    function carregaStatus: Boolean;
    function existe_DESC(codigo: string): Boolean;
  public

  end;

var
  Form_CadastroProduto: TForm_CadastroProduto;

implementation

{$R *.dfm}

Uses
  FAG.Menu, FAG.DataModule.Conexao, FAG.CadastroUnMedida, FAG.CadastroCategoria,
  FAG.ConsultarProduto, FAG.Utils;

procedure TForm_CadastroProduto.Edit_valorChange(Sender: TObject);
var
  s: string;
  v: double;
  I: integer;
begin
  // 1� Passo : se o edit estiver vazio, nada pode ser feito.
  If (Edit_valor.Text = emptystr) then
    Edit_valor.Text := '0,00';

  // 2� Passo : obter o texto do edit, SEM a virgula e SEM o ponto decimal:
  s := '';
  for I := 1 to length(Edit_valor.Text) do
    if (Edit_valor.Text[I] in ['0' .. '9']) then
      s := s + Edit_valor.Text[I];

  // 3� Passo : fazer com que o conte�do do edit apresente 2 casas decimais:
  v := strtofloat(s);
  v := (v / 100); // para criar 2 casa decimais

  // 4� Passo : Formata o valor de (V) para aceitar valores do tipo 0,10.
  Edit_valor.Text := FormatFloat('###,##0.00', v);
  Edit_valor.selstart := length(Edit_valor.Text);
end;

procedure TForm_CadastroProduto.Edit_valorExit(Sender: TObject);
begin
  // Edit_valor.Text := CurrToStrF(StrToCurrDef(Trim(Edit_valor.Text),0),ffNumber,2);
end;

procedure TForm_CadastroProduto.Edit_valorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if NOT(Key in ['0' .. '9', #8, #9]) then
    Key := #0;
  // Fun��o para posicionar o cursor sempre na direita
  Edit_valor.selstart := length(Edit_valor.Text);
end;

procedure TForm_CadastroProduto.FormActivate(Sender: TObject);
begin
  carregaCategoria;
end;

procedure TForm_CadastroProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := CaFree;
  Release;
  Form_CadastroProduto := nil;
end;

procedure TForm_CadastroProduto.FormCreate(Sender: TObject);
begin
  carregaCategoria;
  carregaUnMedida;
  carregaStatus;
  // SetWindowLong(Handle, GWL_STYLE,
  // GetWindowLong(Handle,GWL_STYLE) and not WS_CAPTION);
  // Height := ClientHeight;
  cancelar;
end;

procedure TForm_CadastroProduto.Frame_CategoriaComboBox_InformacaoExit
  (Sender: TObject);
begin
  Frame_Categoria.ComboBox_InformacaoExit(Sender);
end;

procedure TForm_CadastroProduto.Frame_CategoriaExit(Sender: TObject);
begin
  // showmessage(Frame_Generico1.TableTemp.FieldByName('cat_id_categoria')
  // .AsString);
  // showmessage(Frame_Generico1.TableTemp.FieldByName('cat_desc').AsString);
  // showmessage(Frame_Generico1.TableTemp.FieldByName('cat_data_cadastro')
  // .AsString);
  // showmessage(Frame_Generico1.TableTemp.FieldByName('cat_data_alterado')
  // .AsString);
end;

procedure TForm_CadastroProduto.Frame_UnMedidaComboBox_InformacaoExit
  (Sender: TObject);
begin
  Frame_UnMedida.ComboBox_InformacaoExit(Sender);
end;

procedure TForm_CadastroProduto.SpeedButton_unMedidaClick(Sender: TObject);
begin
  Form_CadastroUnMedida := TForm_CadastroUnMedida.Create(Self);
  try
    Form_CadastroUnMedida.ShowModal;
  finally
    Form_CadastroUnMedida.Free;
  end;
end;

procedure TForm_CadastroProduto.SpeedButton_pesquisarClick(Sender: TObject);
begin
  Form_ConsultarProduto := TForm_ConsultarProduto.Create(Self);
  try
    if Form_ConsultarProduto.ShowModal = mrOk then
      loadTela(Form_ConsultarProduto.FDMemTable_consultaProduto.FieldByName
        ('C�digo').AsString);
  finally
    FreeAndNil(Form_ConsultarProduto)
  end;
end;

procedure TForm_CadastroProduto.loadTela(id: string);
var
  carrega: TFDMemTable;
begin
  carrega := TFDMemTable.Create(Self);
  try
    DataModuleConexao.ExecSQL
      ('SELECT prod_id_produto, prod_ativo, prod_desc, cat_id_categoria, un_medida_id, prod_data_cadastro, prod_valor  FROM produto WHERE prod_id_produto  = '
      + id, carrega);
    Edit_codigo.Text := carrega.FieldByName('prod_id_produto').AsString;
    ComboBox_status.ItemIndex := carrega.FieldByName('prod_ativo').AsInteger;
    Edit_descricao.Text := carrega.FieldByName('prod_desc').AsString;
    Frame_Categoria.ComboBox_Informacao.ItemIndex :=
      carrega.FieldByName('cat_id_categoria').AsInteger;
    DateTimePicker1.Date := carrega.FieldByName('prod_data_cadastro').Value;
    Frame_UnMedida.ComboBox_Informacao.ItemIndex :=
      carrega.FieldByName('un_medida_id').AsInteger;
    Edit_valor.Text := FormatFloat('###,##0.00',
      carrega.FieldByName('prod_valor').Value);
  finally
    FreeAndNil(carrega);
  end;

end;

procedure TForm_CadastroProduto.SpeedButton_cancelarClick(Sender: TObject);
begin
  cancelar;
end;

procedure TForm_CadastroProduto.SpeedButton_sairClick(Sender: TObject);
begin
  Form_CadastroProduto.Close;
end;

procedure TForm_CadastroProduto.SpeedButton_salvarClick(Sender: TObject);
begin
  gravar;
end;

function TForm_CadastroProduto.validarCampos: Boolean;
begin
  Result := False;
  if Edit_descricao.Text = '' then
  begin
    Application.MessageBox(PCHAR('Informe a descri��o.'),
      'Aten��o, campo vazio!', MB_ICONWARNING + MB_OK + MB_TASKMODAL);
    Edit_descricao.SetFocus;
  end
  else if Edit_valor.Text = '' then
  begin
    Application.MessageBox(PCHAR('Informe o valor.'), 'Aten��o, campo vazio!',
      MB_ICONWARNING + MB_OK + MB_TASKMODAL);
    Edit_valor.SetFocus
  end
  else if strtofloat(Edit_valor.Text) = 0 then
  begin
    Application.MessageBox(PCHAR('Informe o valor.'), 'Aten��o, campo vazio!',
      MB_ICONWARNING + MB_OK + MB_TASKMODAL);
    Edit_valor.SetFocus;
  end
  else if ComboBox_status.ItemIndex = 0 then
  begin
    Application.MessageBox(PCHAR('Informe o status.'), 'Aten��o, campo vazio!',
      MB_ICONWARNING + MB_OK + MB_TASKMODAL);
    ComboBox_status.SetFocus;
  end
  else if Frame_Categoria.indexCombo.ToInteger = 0 then
  begin
    Application.MessageBox(PCHAR('Informe a categoria.'),
      'Aten��o, campo vazio!', MB_ICONWARNING + MB_OK + MB_TASKMODAL);
    Frame_Categoria.ComboBox_Informacao.SetFocus;
  end
  else if Frame_UnMedida.ComboBox_Informacao.ItemIndex = 0 then
  begin
    Application.MessageBox(PCHAR('Informe a Un. de medida.'),
      'Aten��o, campo vazio!', MB_ICONWARNING + MB_OK + MB_TASKMODAL);
    Frame_UnMedida.ComboBox_Informacao.SetFocus;
  end
  else
  begin
    Result := True;
  end;
end;

function TForm_CadastroProduto.existe_produto(codigo: string): Boolean;
var
  excist: TFDMemTable;
begin
  excist := TFDMemTable.Create(Self);
  try
    DataModuleConexao.ExecSQL
      ('SELECT prod_id_produto FROM produto WHERE prod_id_produto = ' +
      StrToSQL(codigo), excist);
    Result := not excist.IsEmpty;
  finally
    FreeAndNil(excist);
  end;
end;

function TForm_CadastroProduto.existe_DESC(codigo: string): Boolean;
var
  excist: TFDMemTable;
begin
  excist := TFDMemTable.Create(Self);
  try
    DataModuleConexao.ExecSQL('SELECT prod_desc FROM produto WHERE prod_desc = '
      + StrToSQL(codigo), excist);
    Result := not excist.IsEmpty;
  finally
    FreeAndNil(excist);
  end;
end;

function TForm_CadastroProduto.gravar: Boolean;
var
  sql: String;
begin
  if not validarCampos then
  begin
    Result := False;
    Exit;
  end;
  begin
    if existe_produto(Edit_codigo.Text) then
    begin
      sql := ('UPDATE produto SET prod_desc = ' + StrToSQL(Edit_descricao.Text)
        + ',' + ' prod_ativo = ' + IntToSQL(ComboBox_status.ItemIndex) + ',' +
        ' prod_data_alterado = ' + DateTimeToSQL(DateTimePicker1.DateTime) +
        ', cat_id_categoria = ' + StrToSQL(Frame_Categoria.indexCombo) + ',' +
        ' un_medida_id = ' + StrToSQL(Frame_UnMedida.indexCombo) + ',' +
        ' prod_valor = ' + VirgulaPorPonto(Edit_valor.Text) + ',' +
        ' prod_userInclude = "' + Form_Menu.usuarioLogado + '"' +
        ' WHERE prod_id_produto = ' + Edit_codigo.Text + '');
      DataModuleConexao.ExecSQL(sql);
      Application.MessageBox(PCHAR('Cadastro alterado com sucesso.'),
            'Aten��o.', MB_ICONINFORMATION + MB_OK + MB_TASKMODAL);
    end
    else
    begin
      if not existe_DESC(Edit_descricao.Text) then
      begin
        sql := ('INSERT INTO produto (prod_id_produto, prod_desc, cat_id_categoria, un_medida_id'
          + ', prod_data_cadastro, prod_ativo, prod_valor, prod_userInclude) VALUES ('
          + Edit_codigo.Text + ',' + StrToSQL(Edit_descricao.Text) + ',' +
          StrToSQL(Frame_Categoria.indexCombo) + ',' +
          StrToSQL(Frame_UnMedida.indexCombo) + ',' +
          DateTimeToSQL(DateTimePicker1.DateTime) + ',' +
          IntToSQL(ComboBox_status.ItemIndex) + ',' +
          VirgulaPorPonto(Edit_valor.Text) + ',"' +
          Form_Menu.usuarioLogado + '")');
        DataModuleConexao.ExecSQL(sql);
        Application.MessageBox(PCHAR('Cadastro incluso com sucesso.'),
            'Aten��o.', MB_ICONINFORMATION + MB_OK + MB_TASKMODAL);
      end
      else
      begin
        Application.MessageBox(PCHAR('O produto ' + Edit_descricao.Text +
          ' j� est� cadastrado.'), 'Aten��o, verifique seus produtos!',
          MB_ICONWARNING + MB_OK + MB_TASKMODAL);
        Edit_descricao.SetFocus;
      end;
    end;
    cancelar;
  end;
end;

procedure TForm_CadastroProduto.BitBtn1Click(Sender: TObject);
begin
  Frame_Categoria.ComboBox_Informacao.SetFocus;
  Self.Perform(WM_NEXTDLGCTL, 0, 0);
  Frame_UnMedida.ComboBox_Informacao.SetFocus;
  Self.Perform(WM_NEXTDLGCTL, 0, 0);
  ComboBox_status.SetFocus;
  gravar;
end;

procedure TForm_CadastroProduto.BitBtn_categoriaClick(Sender: TObject);
begin
  Form_CadastroCategoria := TForm_CadastroCategoria.Create(Self);
  try
    if Form_CadastroCategoria.ShowModal = mrOk then
      carregaCategoria;
    Frame_Categoria.ComboBox_Informacao.ItemIndex :=
      StrToInt(Form_CadastroCategoria.Edit_codigo.Text);
  finally
    Form_CadastroCategoria.Free;
  end;
end;

procedure TForm_CadastroProduto.BitBtn_unMedidaClick(Sender: TObject);
begin
  Form_CadastroUnMedida := TForm_CadastroUnMedida.Create(Self);
  try
    if Form_CadastroUnMedida.ShowModal = mrOk then
      carregaUnMedida;
    Frame_UnMedida.ComboBox_Informacao.ItemIndex :=
      StrToInt(Form_CadastroUnMedida.Edit_codigoUnMedida.Text);
  finally
    Form_CadastroUnMedida.Free;
  end;
end;

function TForm_CadastroProduto.cancelar: Boolean;
begin
  Edit_codigo.Text := getUltimoID;
  Edit_descricao.clear;
  Frame_Categoria.ComboBox_Informacao.ItemIndex := 0;
  Frame_UnMedida.ComboBox_Informacao.ItemIndex := 0;
  DateTimePicker1.DateTime := Date;
  ComboBox_status.ItemIndex := 0;
  Edit_valor.clear;
end;

function TForm_CadastroProduto.getUltimoID: String;
var
  excist: TFDMemTable;
begin
  excist := TFDMemTable.Create(Self);
  try
    DataModuleConexao.ExecSQL
      ('SELECT COALESCE(MAX(prod_id_produto)+1, 1) AS ID FROM produto', excist);
    Result := excist.FieldByName('ID').AsString;
  finally
    FreeAndNil(excist);
  end;
end;

function TForm_CadastroProduto.carregaCategoria: Boolean;
begin
  Frame_Categoria.tabela := 'categoria';
  Frame_Categoria.campoChave := 'cat_id_categoria';
  Frame_Categoria.campoDescricao := 'cat_desc';
  // Frame_Categoria.camposExtras := ',cat_data_cadastro, cat_data_alterado';
  Frame_Categoria.condicao := '';
  Frame_Categoria.titulo := 'Categorias';
  Frame_Categoria.primeiraOpcao := 'Escolha';
  Frame_Categoria.carregaFrame := True;
end;

function TForm_CadastroProduto.carregaUnMedida: Boolean;
begin
  Frame_UnMedida.tabela := 'un_medida';
  Frame_UnMedida.campoChave := 'un_medida_id';
  Frame_UnMedida.campoDescricao := 'un_medida_desc';
  Frame_UnMedida.campoSigla := 'un_medida_sigla';
  // Frame_UnMedida.camposExtras := ',un_medida_sigla';
  Frame_UnMedida.condicao := '';
  Frame_UnMedida.titulo := 'Un. Medida';
  Frame_UnMedida.primeiraOpcao := 'Escolha';
  Frame_UnMedida.carregaFrame := True;
end;

function TForm_CadastroProduto.carregaStatus: Boolean;
begin
  ComboBox_status.clear;
  ComboBox_status.Style := csDropDownList;
  ComboBox_status.Items.Add('Selecione');
  ComboBox_status.Items.Add('1 - Ativo');
  ComboBox_status.Items.Add('2 - Inativo');
  ComboBox_status.ItemIndex := 0;
end;

end.
