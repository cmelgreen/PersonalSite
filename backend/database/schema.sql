DROP TABLE post;

CREATE TABLE post(
    id int PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    title varchar(255) UNIQUE,
    summary varchar(255),
    content text
);

CREATE TABLE tag(
    id int PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    value varchar(50)
);

CREATE TABLE post_tag(
    post_id int REFERENCES post (id) ON DELETE CASCADE,
    tag_id int REFERENCES tag (id) ON DELETE CASCADE
);

CREATE VIEW post_to_tag AS
    SELECT post.title, post.id as post_id, tag.id as tag_id, tag.value
    FROM post, post_tag, tag
    WHERE post.id = post_tag.post_id AND tag.id = post_tag.tag_id;

INSERT INTO post (title, summary, content)
VALUES 
	('AAA', 'aaa', 'Post 1 is fun'),
    ('BBB', 'bbb', 'Post 2 for you'),
    ('CCC', 'ccc', 'Post 3 for me'),
    ('DDD', 'ddd', 'Post 4 some more');
    
INSERT INTO tag (value)
VALUES 
	('letter a'),
    ('letter b/c');
    
INSERT INTO post_tag
SELECT post.id, tag.id
FROM post CROSS JOIN tag
WHERE post.title in ('BBB', 'CCC')
	AND tag.value = 'letter b/c';
    
INSERT INTO post_tag
SELECT post.id, tag.id
FROM post CROSS JOIN tag
WHERE post.title  = 'AAA'
	AND tag.value IN ('letter a', 'LET A')