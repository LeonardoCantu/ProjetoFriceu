program Integrador;

{$R *.dres}

uses
  Vcl.Forms,
  FAG.Login in 'FAG.Login.pas' {Form_Login},
  FAG.DataModule.Conexao in 'FAG.DataModule.Conexao.pas' {DataModuleConexao: TDataModule},
  FAG.Menu in 'FAG.Menu.pas' {Form_Menu},
  FAG.CadastroProduto in 'FAG.CadastroProduto.pas' {Form_CadastroProduto},
  FAG.CadastroUnMedida in 'FAG.CadastroUnMedida.pas' {Form_CadastroUnMedida},
  FAG.Frame.Generico in 'FAG.Frame.Generico.pas' {Frame_Generico: TFrame},
  FAG.CadastroCategoria in 'FAG.CadastroCategoria.pas' {Form_CadastroCategoria},
  FAG.Movimento in 'FAG.Movimento.pas' {Form_Movimento},
  FAG.Produtos in 'FAG.Produtos.pas' {Form_Produtos},
  FAG.RelatorioMovimento in 'FAG.RelatorioMovimento.pas' {Form_RelatorioMovimento},
  FAG.Frame.Produto in 'FAG.Frame.Produto.pas' {Frame_Produto: TFrame},
  FAG.ConsultarProduto in 'FAG.ConsultarProduto.pas' {Form_ConsultarProduto},
  FAG.RelatorioProduto in 'FAG.RelatorioProduto.pas' {Form_RelatorioProduto},
  FAG.RelatorioUsuario in 'FAG.RelatorioUsuario.pas' {Form_RelatorioUsuario},
  FAG.Frame.UnMedida in 'FAG.Frame.UnMedida.pas' {Frame_UnMedida: TFrame},
  FAG.Utils in 'FAG.Utils.pas',
  FAG.CadastroUsuario in 'FAG.CadastroUsuario.pas' {Form_CadastroUsuario},
  FAG.DetalharMovimento in 'FAG.DetalharMovimento.pas' {Form_detalharMovimento},
  FAG.ConsultaUsuario in 'FAG.ConsultaUsuario.pas' {Form_ConsultaUsuario};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModuleConexao, DataModuleConexao);
  Application.CreateForm(TForm_Menu, Form_Menu);
  Application.Run;
end.
