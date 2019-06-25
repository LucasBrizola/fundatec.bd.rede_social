drop database if exists rs;
create database rs;
use rs;

create table usuario(
id_usuario int primary key,
nome_usuario varchar(45) not null
);

create table postagem(
id_postagem int primary key,
postagem varchar(126) not null,
id_criador_postagem int not null,
foreign key(id_criador_postagem) references usuario(id_usuario)
);

create table comentario(
id_comentario int primary key,
id_criador_comentario int not null,
comentario varchar(45) not null,
foreign key(id_criador_comentario) references usuario(id_usuario)
);

create table reacao(
id_reacao int primary key,
reacao varchar(45) not null
);

create table comentario_postagem(
cp_id int primary key,
postagem_id int not null,
comentario_id int not null,
postagem_criador_id int not null,
comentario_criador_id int not null,
foreign key(postagem_id) references postagem(id_postagem),
foreign key(comentario_id) references comentario(id_comentario),
foreign key(postagem_criador_id) references postagem(id_criador_postagem),
foreign key(comentario_criador_id) references comentario(id_criador_comentario)
);

create table reacao_postagem(
rp_id int not null primary key,
postagem_id int not null,
reacao_id int not null,
postagem_criador_id int not null,
reacao_criador_id int not null,
foreign key(reacao_criador_id) references usuario(id_usuario),
foreign key(postagem_criador_id) references postagem(id_criador_postagem),
foreign key(postagem_id) references postagem(id_postagem),
foreign key(reacao_id) references reacao(id_reacao)
);


insert into usuario(id_usuario, nome_usuario) values
(01,"lucas"),
(02,"rik"),
(03,"yuri"),
(04,"barbara"),
(05,"hikari"),
(06,"fabio"),
(07,"bruno"),
(08,"vivian"),
(09,"tassio");

insert into postagem(id_postagem, postagem, id_criador_postagem) values
(101,"ola mundo",01),
(102,"to no trabalho e vcs nao",01),
(103,"agora entendi!",02),
(104,"fome",03),
(105,"to braba",04),
(106,"sou foda",05),
(107,"prefiro c#",05),
(108,"vou chegar atrasado",05),
(109,"novo papai",06),
(110,"kd minha filha",08),
(111,"kd meu marido",08),
(112,"vem pra carona Rik e Tassio",08),
(113,"vamo embora lucas",03),
(114,"nintendo switch",09),
(115,"eu nao vou precisar disso pra vida, quero so codar",09),
(116,"quero tirar um 10 pfv",01);

insert into comentario(id_comentario, comentario, id_criador_comentario) values
(1000,"to indo", 9),
(1001,"tb to indo",2),
(1002,"quem disse que nao",3),
(1003,"eu tb to",2),
(1004,"to braba no trabalho",4),
(1005,"to tomando cafezinho",5),
(1006,"alguem me indica pfv",9),
(1007,"vou la comprar comida",5),
(1008,"to indo junto meu gostoso",6),
(1009,"kkkkkkk",1),
(1010,"parece ate eu, braba",4),
(1011,"hikari tb quero carona, senao fico braba",4),
(1012,"parabens!",1),
(1013,"parabens!",2),
(1014,"parabens!",3),
(1015,"parabens!",4),
(1016,"parabens!",5),
(1017,"parabens!",7),
(1018,"parabens!",8),
(1019,"parabens!",9),
(1020,"to indo yuriiiiii",1),
(1021,"e eu, fodinha",7),
(1022,"e lindao",6),
(1023,"eu sou braba",4),
(1024,"ela ja chegou",7);

insert into reacao(id_reacao, reacao) values
(51, "gostei"),
(52, "amei"),
(53, "haha"),
(54, "triste"),
(55, "grr");

SET foreign_key_checks = 0;

insert into comentario_postagem(cp_id, postagem_id, postagem_criador_id, comentario_id, comentario_criador_id) values
(600,112,8,1000,9),
(601,112,8,1001,3),
(602,102,1,1003,2),
(603,102,1,1004,4),
(604,102,1,1005,5),
(605,102,1,1006,6),
(606,104,3,1007,7),
(607,104,3,1008,8),
(608,115,9,1009,1),
(609,112,8,1010,4),
(610,115,9,1011,3),
(611,109,6,1012,9),
(612,109,6,1013,4),
(613,109,6,1014,1),
(614,109,6,1015,2),
(615,109,6,1016,3),
(616,109,6,1017,4),
(617,109,6,1018,5),
(618,109,6,1019,7),
(619,113,3,1020,8),
(620,113,3,1021,9),
(621,106,5,1021,7),
(622,106,5,1022,6),
(623,106,5,1023,4),
(624,110,8,1024,7),
(625,102,1,1002,3);

insert into reacao_postagem(rp_id, postagem_id, postagem_criador_id, reacao_id, reacao_criador_id) values
(300, 101,1,51,2),
(301, 101,1,51,3),
(302, 101,1,55,4),
(303, 101,1,51,5),
(304, 101,1,51,6),
(305, 101,1,51,7),
(306, 101,1,51,8),
(307, 101,1,51,9),
(308, 102,1,51,2),
(309, 102,1,53,3),
(310, 102,1,53,9),
(311, 102,1,54,5),
(312, 103,2,55,4),
(313, 104,3,55,4),
(314, 105,4,55,4),
(315, 106,5,55,4),
(316, 108,5,55,4);


SET foreign_key_checks = 1;

-- exercicio 1: postagens que não são do usuario lucas

select usuario.nome_usuario, postagem.postagem
from postagem
left join usuario on usuario.id_usuario = postagem.id_criador_postagem
where usuario.nome_usuario not like "lucas";

-- exercicio 2: 

select postagem.postagem, comentario.comentario, usuario.nome_usuario
from comentario_postagem
left join postagem on postagem.id_postagem = comentario_postagem.postagem_id
left join comentario on comentario.id_comentario = comentario_postagem.comentario_id
left join usuario on comentario_postagem.comentario_criador_id = usuario.id_usuario
order by id_postagem asc, id_comentario asc
;

-- exercício 3:

select postagem.postagem, reacao.reacao, count(reacao.id_reacao) as "numero de reacoes"
from reacao_postagem
left join postagem on postagem.id_postagem = reacao_postagem.postagem_id
left join reacao on reacao.id_reacao = reacao_postagem.reacao_id
group by postagem.postagem, reacao.reacao
order by postagem.id_postagem;