use kino;
DROP procedure IF EXISTS `Ville`;
DELIMITER $$
create procedure Ville(out biggest int,out villeWin varchar(100),out smallest int,out villeMin varchar(100))
begin
    DECLARE max int DEFAULT 0 ;
    DECLARE cnt int DEFAULT 0 ;
    DECLARE ville varchar(100);
    DECLARE counterVille int DEFAULT 0 ;
    DECLARE biggest int DEFAULT 0 ;
    DECLARE smallest int DEFAULT 1000 ;
    DECLARE villeWin varchar(100);
    DECLARE villeMin varchar(100);
    create temporary table ville select DISTINCT(stadt) from folge ;
    select count(*) into max from ville;
    WHILE cnt < max
    DO
        set ville = (select * from ville limit 1 offset cnt);
        
        SET counterVille = (select count(*) from folge where stadt=ville);
        IF counterVille > biggest
        then
            set biggest = counterVille;
            set villeWin = ville;
        END IF;
        IF counterVille < smallest
        then
            set smallest = counterVille;
            set villeMin = ville;
        END IF;
        set cnt = cnt +1;
    END WHILE;
    select biggest,villeWin,smallest,villeMin;
    drop table ville;
END;


