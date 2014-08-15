CREATE UNIQUE INDEX name_index ON domains(name);

CREATE INDEX nametype_index ON records(name,type);
CREATE INDEX domain_id ON records(domain_id);
CREATE INDEX recordorder ON records (domain_id, ordername);

CREATE INDEX comments_domain_id_idx ON comments (domain_id);
CREATE INDEX comments_name_type_idx ON comments (name, type);
CREATE INDEX comments_order_idx ON comments (domain_id, modified_at);

CREATE INDEX domainmetadata_idx ON domainmetadata (domain_id, kind);

CREATE INDEX domainidindex ON cryptokeys(domain_id);

CREATE UNIQUE INDEX namealgoindex ON tsigkeys(name, algorithm);

ALTER TABLE `records` ADD CONSTRAINT `records_ibfk_1` FOREIGN KEY (`domain_id`)
REFERENCES `domains` (`id`) ON DELETE CASCADE;
