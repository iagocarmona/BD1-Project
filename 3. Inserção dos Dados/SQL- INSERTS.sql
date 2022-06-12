
-- -------------------------------------------------------------------------
-- LINK DO REPOSITÓRIO -> https://github.com/iagocarmona/BD1-Projeto
-- -------------------------------------------------------------------------

DROP TABLE IF EXISTS PEDIDO_TEM_EQUIPAMENTO;
DROP TABLE IF EXISTS FORNECEDOR_FORNECE_PRODUTO;
DROP TABLE IF EXISTS FUNCIONARIO_GERENCIA_PEDIDO;
DROP TABLE IF EXISTS EQUIPAMENTO_TEM_JOGO;
DROP TABLE IF EXISTS CLIENTE_UTILIZA_EQUIPAMENTO;
DROP TABLE IF EXISTS FUNCIONARIO_ARRUMA_EQUIPAMENTO;
DROP TABLE IF EXISTS FUNCIONARIO_ATENDE_CLIENTE;
DROP TABLE IF EXISTS ENDERECO;
DROP TABLE IF EXISTS PRODUTO_ACESSORIOS;
DROP TABLE IF EXISTS PRODUTO_PECASCOMPUTADOR;
DROP TABLE IF EXISTS PRODUTO;
DROP TABLE IF EXISTS NOTA_FISCAL;
DROP TABLE IF EXISTS PEDIDO;
DROP TABLE IF EXISTS FORNECEDOR;
DROP TABLE IF EXISTS JOGO;
DROP TABLE IF EXISTS EQUIP_CONSOLE;
DROP TABLE IF EXISTS EQUIP_COMPUTADOR;
DROP TABLE IF EXISTS EQUIPAMENTO;
DROP TABLE IF EXISTS FUNCIONARIO;
DROP TABLE IF EXISTS REPARO;
DROP TABLE IF EXISTS CLIENTE;

CREATE TABLE CLIENTE(
	cpf CHAR(11),
    rg CHAR(9),
    telefone CHAR(8),
    email VARCHAR(200),
    nome VARCHAR(100),
    PRIMARY KEY (cpf)
);

CREATE TABLE REPARO(
	codigo INTEGER,
    preco DECIMAL(10,2),
    tipoEquipamento VARCHAR(20),
    descricao VARCHAR(200),
    cpfCliente CHAR(11),
    PRIMARY KEY (codigo),
    FOREIGN KEY (cpfCliente) REFERENCES CLIENTE(cpf)
);

CREATE TABLE FUNCIONARIO(
	cpf CHAR(11),
    rg CHAR (9),
    salario DECIMAL(10,2),
    nome VARCHAR(100),
    codigoReparo INTEGER,
    PRIMARY KEY(cpf),
    FOREIGN KEY (codigoReparo) REFERENCES REPARO(codigo)
);

CREATE TABLE EQUIPAMENTO(
	id INTEGER,
	precoH DECIMAL(10,2),
    statusDisponibilidade VARCHAR(20),
	PRIMARY KEY (id)
);

CREATE TABLE EQUIP_COMPUTADOR(
	idEquip INTEGER,
	login VARCHAR(20),
    senha VARCHAR(8),
    sistema VARCHAR(30),
    PRIMARY KEY (idEquip),
    FOREIGN KEY (idEquip) REFERENCES EQUIPAMENTO(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE EQUIP_CONSOLE(
	idEquip INTEGER,
    qtdeControle INTEGER,
    tipo VARCHAR(100),
    PRIMARY KEY (idEquip),
    FOREIGN KEY (idEquip) REFERENCES EQUIPAMENTO(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE JOGO(
	id INTEGER,
    nome VARCHAR(100),
    dataInstalacao DATE,
    nomeProdutora VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE FORNECEDOR(
	cnpj CHAR(14),
    nomeEmpresa VARCHAR(100),
    nomeFornecedor VARCHAR(100),
    PRIMARY KEY (cnpj)
);

CREATE TABLE PEDIDO(
	numero INTEGER,
    valorTotal DECIMAL(10,2),
    tempoTotalEquip VARCHAR(100),
    cpfCliente CHAR(11),
    PRIMARY KEY (numero),
    FOREIGN KEY (cpfCliente) REFERENCES CLIENTE (cpf)
);

CREATE TABLE NOTA_FISCAL(
	numPedido INTEGER UNIQUE,
    razaoSocial VARCHAR(100),
    cnpj CHAR(14),
    email VARCHAR(100),
    totalPagar DECIMAL(10,2),
    PRIMARY KEY (numPedido),
    FOREIGN KEY (numPedido) REFERENCES PEDIDO(numero) ON DELETE CASCADE
);

CREATE TABLE PRODUTO(
	id INTEGER,
    nome VARCHAR(100),
    preco DECIMAL(10,2),
    cpfCliente CHAR(11),
    PRIMARY KEY (id),
    FOREIGN KEY (cpfCliente) REFERENCES CLIENTE (cpf)
);

CREATE TABLE PRODUTO_PECASCOMPUTADOR(
	idProduto INTEGER,
    modelo VARCHAR(100),
    marca VARCHAR(100),
    fabricante VARCHAR(100),
    PRIMARY KEY (idProduto),
    FOREIGN KEY (idProduto) REFERENCES PRODUTO (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PRODUTO_ACESSORIOS(
	idProduto INTEGER,
    tipo VARCHAR(100),
    PRIMARY KEY (idProduto),
    FOREIGN KEY (idProduto) REFERENCES PRODUTO(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ENDERECO(
	estado CHAR(2),
    rua VARCHAR(100),
    bairro VARCHAR(100),
    numero INTEGER,
    cidade VARCHAR(100),
    cpfFuncionario VARCHAR(11),
    PRIMARY KEY (cpfFuncionario),
    FOREIGN KEY (cpfFuncionario) REFERENCES FUNCIONARIO(cpf) ON DELETE CASCADE
);

CREATE TABLE FUNCIONARIO_ATENDE_CLIENTE(
	cpfCliente CHAR(11),
    cpfFuncionario CHAR(11),
    PRIMARY KEY (cpfCliente, cpfFuncionario),
    FOREIGN KEY (cpfCliente) REFERENCES CLIENTE(cpf),
    FOREIGN KEY (cpfFuncionario) REFERENCES FUNCIONARIO(cpf)
);

CREATE TABLE FUNCIONARIO_ARRUMA_EQUIPAMENTO(
	idEquip INTEGER,
    cpfFuncionario CHAR(11),
    PRIMARY KEY (idEquip, cpfFuncionario),
    FOREIGN KEY (idEquip) REFERENCES EQUIPAMENTO(id),
    FOREIGN KEY (cpfFuncionario) REFERENCES FUNCIONARIO(cpf)
);

CREATE TABLE CLIENTE_UTILIZA_EQUIPAMENTO(
	idEquip INTEGER,
    cpfCliente CHAR(11),
    PRIMARY KEY (idEquip, cpfCliente),
    FOREIGN KEY (idEquip) REFERENCES EQUIPAMENTO (id),
    FOREIGN KEY (cpfCliente) REFERENCES CLIENTE(cpf)
);

CREATE TABLE EQUIPAMENTO_TEM_JOGO(
	idEquip INTEGER,
    idJogo INTEGER,
    PRIMARY KEY (idEquip, idJogo),
    FOREIGN KEY (idEquip) REFERENCES EQUIPAMENTO (id),
    FOREIGN KEY (idJogo) REFERENCES JOGO(id)
);

CREATE TABLE FUNCIONARIO_GERENCIA_PEDIDO(
	numeroPedido INTEGER,
    cpfFuncionario CHAR(11),
    PRIMARY KEY (numeroPedido, cpfFuncionario),
    FOREIGN KEY (numeroPedido) REFERENCES PEDIDO(numero),
    FOREIGN KEY (cpfFuncionario) REFERENCES FUNCIONARIO(cpf)
);

CREATE TABLE FORNECEDOR_FORNECE_PRODUTO(
	cnpjFornecedor CHAR(14),
    idProduto INTEGER,
	PRIMARY KEY (cnpjFornecedor, idProduto),
    FOREIGN KEY (cnpjFornecedor) REFERENCES FORNECEDOR(cnpj),
    FOREIGN KEY (idProduto) REFERENCES PRODUTO(id)
);

CREATE TABLE PEDIDO_TEM_EQUIPAMENTO(
	idEquip INTEGER,
    pedidoNumero INTEGER,
    PRIMARY KEY (idEquip, pedidoNumero),
    FOREIGN KEY (idEquip) REFERENCES EQUIPAMENTO (id),
    FOREIGN KEY (pedidoNumero) REFERENCES PEDIDO(numero)
);

insert into CLIENTE(cpf, rg, telefone, email, nome) values 
('29639120561', '768561732', '32223517', 'smcinulty0@feedburner.com', 'Stefania McInulty'),
('40839973710', '925742285', '81530885', 'tsmallridge1@tripod.com', 'Tracee Smallridge'),
('88063886507', '877491151', '88607827', 'ochallener2@netlog.com', 'Ogdon Challener'),
('53488994544', '157091835', '10832088', 'cmarrison3@paginegialle.it', 'Chauncey Marrison'),
('86509520611', '362953579', '32454618', 'lmcelwee4@godaddy.com', 'Libbey McElwee'),
('85744188155', '138999707', '61482023', 'sfirth5@imageshack.us', 'Sutton Firth'),
('88081962812', '704187453', '98189551', 'cjackalin6@wufoo.com', 'Carmel Jackalin'),
('16640482723', '605901776', '28106449', 'kfeldheim7@altervista.org', 'Karon Feldheim'),
('65995272307', '456956000', '61906355', 'epeet8@dailymail.co.uk', 'Eb Peet'),
('84449986624', '500613367', '53401028', 'hmcinerney9@nbcnews.com', 'Haywood McInerney');

insert into REPARO(codigo, preco, tipoEquipamento, descricao, cpfCliente) values 
(1, 343.50, 'notebook', 'formatar e limpar', '29639120561'),
(2, 540.30, 'notebook', 'formatar e trocar memória ram', '40839973710'),
(3, 28.00, 'desktop', 'trocar pasta térmica', '88063886507'),
(4, 482.00, 'desktop', 'trocar placa mãe', '53488994544'),
(5, 300.00, 'notebook', 'arrumar carcaça', '86509520611'),
(6, 487.00, 'notebook', 'formatar e arrumar display', '85744188155'),
(7, 487.99, 'console', 'trocar memória ram e arrumar cabo flat', '88081962812'),
(8, 100.00, 'console', 'arrumar ventoinhas e limpar', '16640482723'),
(9, 15.00, 'notebook', 'trocar pasta térmica', '65995272307'),
(10, 253.00, 'desktop', 'trocar ventoinha da placa de vídeo', '84449986624');

insert into FUNCIONARIO (cpf, rg, salario, nome, codigoReparo) values 
('57433870102', '731016306', 1500.00, 'Shina Harder', 1),
('80280057850', '905492729', 1500.00, 'Julienne Filipic', 2),
('19798439734', '214768681', 1500.00, 'Warren McComish', 3),
('17331434379', '194362802', 1500.00, 'Leann Pemberton', 4),
('87925400034', '636063675', 2000.00, 'Sawyer Lindfors', 5),
('56398398714', '679763998', 2000.00, 'Dasi Byk', 6),
('80532800175', '366083953', 3000.00, 'Leighton Tromans', 7),
('77279950104', '220738988', 2500.00, 'Dexter Akitt', 8),
('17576646973', '388451093', 2500.00, 'Cloris Dermott', 9),
('70354031297', '947154066', 3000.00, 'Jammal Wornham', 10);

insert into EQUIPAMENTO(id, precoH, statusDisponibilidade) values
(1, 5.00, 'disponível'), (2, 4.00, 'indisponível'), (3, 4.00, 'indisponível'),
(4, 3.00, 'indisponível'), (5, 5.00, 'indisponível'), (6, 5.00, 'indisponível'),
(7, 4.00, 'disponível'), (8, 5.00, 'disponível'), (9, 6.00, 'disponível'),
(10, 3.00, 'disponível'), (11, 3.00, 'indisponível'), (12, 4.00, 'indisponível'),
(13, 5.00, 'indisponível'), (14, 5.00, 'disponível'), (15, 5.00, 'disponível'),
(16, 3.00, 'indisponível'), (17, 3.00, 'indisponível'), (18, 3.00, 'indisponível'),
(19, 5.00, 'indisponível'), (20, 5.00, 'indisponível');

insert into EQUIP_COMPUTADOR(idEquip, login, senha, sistema) values
(1, 'equip1', 'equip111', 'Windows 10 64Bits'),
(2, 'equip2', 'equip222', 'Windows 11 64Bits'),
(3, 'equip3', 'equip333', 'Windows 10 64Bits'),
(4, 'equip4', 'equip444', 'Windows 8 64Bits'),
(5, 'equip5', 'equip555', 'Windows 11 64Bits'),
(6, 'equip6', 'equip666', 'Windows 8 64Bits'),
(7, 'equip7', 'equip777', 'Windows 7 64Bits'),
(8, 'equip8', 'equip888', 'Linux Ubuntu 64Bits'),
(9, 'equip9', 'equip999', 'Linux Mint 64Bits'),
(10, 'equip10', 'equip101', 'Linux Lubuntu 64Bits');

insert into EQUIP_CONSOLE(idEquip, qtdeControle, tipo) values
(11, 2, 'PlayStation 4'),
(12, 3, 'PlayStation 3'),
(13, 3, 'PlayStation 4'),
(14, 4, 'PlayStation 5'),
(15, 4, 'Xbox 360'),
(16, 4, 'Xbox 360'),
(17, 2, 'Xbox ONE'),
(18, 2, 'Xbox ONE'),
(19, 1, 'PlayStation 3'),
(20, 1, 'Xbox ONE');

insert into JOGO(id, nome, dataInstalacao, nomeProdutora) values
(1, 'BattleField 1', '2020-03-26', 'DICE'),
(2, 'BattleField 2', '2020-04-12', 'DICE'),
(3, 'BattleField 3', '2020-05-22', 'DICE'),
(4, 'Counter Strike:Global Offensive', '2018-01-12', 'Valve'),
(5, 'Fortnite', '2021-02-18', 'Epic Games'),
(6, 'Rocket League', '2017-04-03', 'Psyonix'),
(7, 'Modern Warfare Warzone', '2021-06-21', 'Infinity Ward'),
(8, 'Sea of Thieves', '2022-02-13', 'Rare'),
(9, 'Minecraft', '2015-08-30', 'Mojang'),
(10, 'Rainbow Six', '2019-09-23', 'Ubsoft');

insert into FORNECEDOR (cnpj, nomeEmpresa, nomeFornecedor) values 
('49048245328784', 'Considine Group', 'Porter Proom'),
('74025009866518', 'Williamson Group', 'Florian Toulch'),
('37560588826305', 'Dibbert LLC', 'Fee McKearnen'),
('69724194257866', 'Halvorson Group', 'Ingunna Henrie'),
('92607896212063', 'Emard, Kovacek and Haley', 'Sharity Judron'),
('76047369061765', 'Hermiston, Morissette and Zulauf', 'Trixy Tarbard'),
('52520078586373', 'Bailey and Sons', 'Corabel Pancast'),
('33883947267429', 'Koepp-Considine', 'Mendel Ead'),
('12632082532645', 'Schulist-Langosh', 'Emlyn Downton'),
('45906133842592', 'Kassulke-Heathcote', 'Matilda Vanini');

insert into PEDIDO (numero, valorTotal, tempoTotalEquip, cpfCliente) values
(1, 10.00, '2 horas', '29639120561'),
(2, 5.00, '1 hora', '40839973710'),
(3, 6.00, '2 horas', '88063886507'),
(4, 12.00, '3 horas', '53488994544'),
(5, 4.00, '1 hora', '86509520611'),
(6, 8.00, '2 horas', '85744188155'),
(7, 4.00, '1 hora', '88081962812'),
(8, 6.00, '2 horas', '16640482723'),
(9, 6.00, '2 horas', '65995272307'),
(10, 8.00, '2 horas', '84449986624');

insert into NOTA_FISCAL(numPedido, razaoSocial, cnpj, email, totalPagar) values 
(1, 'Gaming Center', '25148547632596', 'gamingcenter@gmail.com', 10.00),
(2, 'Gaming Center', '25148547632596', 'gamingcenter@gmail.com', 5.00),
(3, 'Gaming Center', '25148547632596', 'gamingcenter@gmail.com', 6.00),
(4, 'Gaming Center', '25148547632596', 'gamingcenter@gmail.com', 12.00),
(5, 'Gaming Center', '25148547632596', 'gamingcenter@gmail.com', 4.00),
(6, 'Gaming Center', '25148547632596', 'gamingcenter@gmail.com', 8.00),
(7, 'Gaming Center', '25148547632596', 'gamingcenter@gmail.com', 4.00),
(8, 'Gaming Center', '25148547632596', 'gamingcenter@gmail.com', 6.00),
(9, 'Gaming Center', '25148547632596', 'gamingcenter@gmail.com', 6.00),
(10, 'Gaming Center', '25148547632596', 'gamingcenter@gmail.com', 8.00);

insert into PRODUTO(id, nome, preco, cpfCliente) values
(1, 'Placa de vídeo', 800.00, '29639120561'),
(2, 'Placa de vídeo', 900.00, '40839973710'),
(3, 'Placa de vídeo', 1000.00, '88063886507'),
(4, 'Memória Ram', 350.00, '53488994544'),
(5, 'Memória Ram', 289.00, '86509520611'),
(6, 'Processador', 450.00, '85744188155'),
(7, 'Processador', 1500.00, '88081962812'),
(8, 'Processador', 500.00, '16640482723'),
(9, 'Disco Rígido', 250.00, '65995272307'),
(10, 'Disco Rígido', 380.00, '84449986624'),
(11, 'Mouse Gamer 10000dpi', 126.00, '29639120561'),
(12, 'Headset Gamer Fortrek', 112.00, '40839973710'),
(13, 'Fones de Ouvido JBL', 633.00, '88063886507'),
(14, 'Mousepad Gamer Fortrek Speed', 25.00, '53488994544'),
(15, 'Teclado Redragon RGB', 220.00, '86509520611'),
(16, 'Webcam 1080p', 150.00, '85744188155'),
(17, 'Mesa Digitalizadora Huion 4000LPI', 150.00, '16640482723'),
(18, 'Hub Usb 7 Portas 2.0', 50.00, '65995272307'),
(19, 'Base para Notebook Multilaser', 148.00, '84449986624'),
(20, 'Cooler FAN Rise Mode Wind W1', 41.00, '29639120561');

insert into PRODUTO_PECASCOMPUTADOR(idProduto, modelo, marca, fabricante) values
(1, 'GTX 1050 4GB', 'NVIDEA', 'Nvidia Corporation'),
(2, 'GTX 1050 TI GB', 'NVIDEA', 'Nvidia Corporation'),
(3, 'GTX 1050 OC 4GB', 'NVIDEA', 'Nvidia Corporation'),
(4, 'DDR4', 'Kingston', 'Kingston Technology'),
(5, 'DDR3', 'Kingston', 'Kingston Technology'),
(6, 'intel core i3', 'Intel', 'Intel Corporation'),
(7, 'intel core i5', 'Intel', 'Intel Corporation'),
(8, 'intel core i7', 'Intel', 'Intel Corporation'),
(9, 'hd 500gb', 'Seagate', 'Seagate Technology'),
(10, 'ssd 256gb', 'Seagate', 'Seagate Technology');

insert into PRODUTO_ACESSORIOS(idProduto, tipo) values
(11, 'Mouse'), (12, 'Headset'), (13, 'Fone Bluetooth'),
(14, 'Mousepad'), (15, 'Teclado'), (16, 'Webcam'),
(17, 'Mesa Digitalizadora'), (18, 'Hub USB'), (19, 'Base Refrigeradora'),
(20, 'Ventoinha');

insert into ENDERECO (estado, rua, bairro, numero, cidade, cpfFuncionario) values 
('PR', 'Rua Ezídio Baladeli', 'Zona 7', 110, 'Cianorte', '57433870102'),
('PR', 'Rua Monte Verde', 'Zona 7', 345, 'Cianorte','80280057850'),
('PR', 'Rua Washington Luis', 'Zona 7', 152, 'Cianorte','19798439734'),
('PR', 'Rua Francisco Tourinho', 'Zona 7', 145,'Cianorte', '17331434379'),
('PR', 'Rua Jordão', 'Zona 7', 1477, 'Cianorte','87925400034'),
('PR', 'Av América', 'Zona 2', 1482, 'Cianorte','56398398714'),
('PR', 'Av América', 'Zona 3', 563, 'Cianorte','80532800175'),
('PR', 'Av Marajó', 'Zona 7', 485, 'Cianorte','77279950104'),
('PR', 'Rua Solimões', 'Zona 4', 320, 'Cianorte','17576646973'),
('PR', 'Rua Japurá', 'Zona 6', 154,'Cianorte','70354031297');

insert into FUNCIONARIO_ATENDE_CLIENTE(cpfCliente, cpfFuncionario) values
('29639120561', '57433870102'), ('40839973710', '80280057850'), ('88063886507', '19798439734'),
('53488994544', '17331434379'), ('86509520611', '87925400034'), ('85744188155', '56398398714'),
('88081962812', '80532800175'), ('16640482723', '77279950104'), ('65995272307', '17576646973'),
('84449986624', '70354031297');

insert into FUNCIONARIO_ARRUMA_EQUIPAMENTO(idEquip, cpfFuncionario) values
(1, '57433870102'), (3, '80280057850'), (5, '19798439734'),
(7, '17331434379'), (9, '87925400034'), (11, '56398398714'),
(13, '80532800175'), (15, '77279950104'), (17, '17576646973'),
(19, '70354031297');

insert into CLIENTE_UTILIZA_EQUIPAMENTO(idEquip, cpfCliente) values
(1, '29639120561'), (3, '40839973710'), (6, '88063886507'),
(8, '53488994544'), (9, '86509520611'), (11, '85744188155'),
(13, '88081962812'), (16, '16640482723'), (18, '65995272307'),
(20, '84449986624');

insert into EQUIPAMENTO_TEM_JOGO(idEquip, idJogo) values
(1, 1), (1, 2), (1, 3), (1, 4), (2, 2), (2, 3), (2, 7), (3, 4), (3, 8), (3, 2), 
(4, 1), (4, 2), (4, 3), (5, 3), (6, 4), (7, 3), (8, 5), (9, 5), (10, 1), (11, 4), 
(12, 4), (14, 2), (15, 8), (16, 8), (17, 9), (17, 5), (17, 4), (20, 3), (20, 5);

insert into FUNCIONARIO_GERENCIA_PEDIDO(numeroPedido, cpfFuncionario) values
(1, '57433870102'), (2, '80280057850'), (3, '19798439734'),
(4, '17331434379'), (5, '87925400034'), (6, '56398398714'),
(7, '80532800175'), (8, '77279950104'), (9, '17576646973'),
(10, '70354031297');

insert into FORNECEDOR_FORNECE_PRODUTO(cnpjFornecedor, idProduto) values
('49048245328784', 1), ('74025009866518', 3), ('37560588826305', 4),
('69724194257866', 5), ('92607896212063', 7), ('76047369061765', 8),
('52520078586373', 10), ('33883947267429', 12), ('12632082532645', 15),
('45906133842592', 20);

insert into PEDIDO_TEM_EQUIPAMENTO(idEquip, pedidoNumero) values
(1,1), (3,2), (4,3), (7,4), (8,5), (9,6),
(12,7), (14,8), (18,9), (20,10);









