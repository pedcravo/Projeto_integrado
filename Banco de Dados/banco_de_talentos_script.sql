

--cria tabela skills e sua PK.
CREATE TABLE skills (
                id_skill NUMERIC NOT NULL,
                nome_skill VARCHAR(255) NOT NULL,
                tipo_skill VARCHAR(1) NOT NULL,
                CONSTRAINT skills_pk PRIMARY KEY (id_skill)
);

--cria comentário para tabela skills e comentários para suas respectivas colunas
COMMENT ON TABLE skills IS 'Esta tabela armazenará todas as skills criadas pelos usuários: com seu ID, nome e tipo (Soft ou Hard).';
COMMENT ON COLUMN skills.id_skill IS 'Atributo que irá armazenar as identificações das skills.';
COMMENT ON COLUMN skills.nome_skill IS 'Atributo que irá armazenar o nome das skills criadas pelos usuários.';
COMMENT ON COLUMN skills.tipo_skill IS 'Atributo que armazenará o tipo de cada skill: se é soft skill (habilidades comportamentais) ou se é hard skill (habilidades técnicas). Constraint de checagem só aceitará valores S ou H.';


--cria tabela usuarios e sua PK
CREATE TABLE usuarios (
                id_usuario NUMERIC NOT NULL,
                nome VARCHAR(255) NOT NULL,
                imagem_perfil BYTEA NOT NULL,
                bio VARCHAR(180),
                email VARCHAR(50) NOT NULL,
                CONSTRAINT usuarios_pk PRIMARY KEY (id_usuario)
);

--cria comentário para tabela usuarios e comentários para suas respectivas colunas
COMMENT ON TABLE usuarios IS 'Esta tabela armazena todos os dados dos usuários cadastrados: ID, nome, imagem de perfil, biografia e email (apenas 1).';
COMMENT ON COLUMN usuarios.id_usuario IS 'ID do usuário, proporcionado pela empresa.';
COMMENT ON COLUMN usuarios.nome IS 'Nome do usuário.';
COMMENT ON COLUMN usuarios.imagem_perfil IS 'Imagem de perfil de cada usuário. ';
COMMENT ON COLUMN usuarios.bio IS 'Biografia de cada usuário. Opcional';
COMMENT ON COLUMN usuarios.email IS 'Email de cada usuário. Só é permitido armazenar 1 email.';


--cria tabela usuarios_skills e sua PK
CREATE TABLE usuarios_skills (
                id_usuario NUMERIC NOT NULL,
                id_skill NUMERIC NOT NULL,
                CONSTRAINT usuarios_skills_pk PRIMARY KEY (id_usuario, id_skill)
);

--cria comentário para tabela usuarios_skills e comentarios para suas respectivas colunas
COMMENT ON TABLE usuarios_skills IS 'Tabela intermediária entre usuários e skills, que não armazena dados, apenas as PFKs';
COMMENT ON COLUMN usuarios_skills.id_usuario IS 'ID do usuário, proporcionado pela empresa.';
COMMENT ON COLUMN usuarios_skills.id_skill IS 'Atributo que irá armazenar as identificações das skills.';

--cria tabela telefones e sua PK
CREATE TABLE telefones (
                id_usuario NUMERIC NOT NULL,
                numero_telefone NUMERIC(11) NOT NULL,
                CONSTRAINT telefones_pk PRIMARY KEY (id_usuario, numero_telefone)
);

--cria comentario para tabela telefones e comentarios para suas respectivas colunas
COMMENT ON TABLE telefones IS 'Esta tabela armazena os telefones de cada usuário.';
COMMENT ON COLUMN telefones.id_usuario IS 'ID do usuário, proporcionado pela empresa.';
COMMENT ON COLUMN telefones.numero_telefone IS 'Número de telefone de cada usuário. Só aceita formato: 27999999999 (DDD e numero, sem caracter separando).';


-- cria foreign key na tabela usuarios_skills, criando relacionamento identificado com skills
ALTER TABLE usuarios_skills ADD CONSTRAINT skills_usuarios_skills_fk
FOREIGN KEY (id_skill)
REFERENCES skills (id_skill)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--cria foreign key na tabela telefones, criando relacionamento identificado com tabela usuarios
ALTER TABLE telefones ADD CONSTRAINT usuarios_telefones_fk
FOREIGN KEY (id_usuario)
REFERENCES usuarios (id_usuario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- cria foreign key na tabela usuarios_skills, criando relacionamento identificado com usuarios
ALTER TABLE usuarios_skills ADD CONSTRAINT usuarios_usuarios_skills_fk
FOREIGN KEY (id_usuario)
REFERENCES usuarios (id_usuario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--cria constraint de checagem na coluna tipo_skill da tabela skills, que só aceita valores S ou H.
ALTER TABLE skills
ADD CONSTRAINT cc_skills_tipo_skill
CHECK (tipo_skill IN ('S', 'H'));
