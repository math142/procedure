use kino;
DROP procedure IF EXISTS `Police`;
DELIMITER $$
create procedure Police(out biggest int, out PolicierMax varchar(100),out smallest int, out PolicierMin varchar(100))
begin
    DECLARE max int DEFAULT 0 ;
    DECLARE cnt int DEFAULT 0 ;
    DECLARE Policier varchar(100);
    DECLARE counterPolicier int DEFAULT 0 ;
    DECLARE biggest int DEFAULT 0 ;
    DECLARE smallest int DEFAULT 1000 ;
    DECLARE PolicierMin varchar(100) ;
    DECLARE PolicierMax varchar(100) ;


    create temporary table police select DISTINCT(Ermittler) from folge ;
    select count(*) into max from police;

    WHILE cnt < max
    DO
        set Policier = (select * from police limit 1 offset cnt);
        set counterPolicier = (select count(*) from folge where Ermittler = Policier);
        IF counterPolicier > biggest
        then
            set biggest = counterPolicier;
            set PolicierMax = Policier;
        END IF;
        IF counterPolicier < smallest
        then
            set smallest = counterPolicier;
            set PolicierMin = Policier;
        END IF;
        set cnt = cnt + 1;
    END WHILE;
    select biggest,PolicierMax,smallest,PolicierMin;
    drop table police;
END;
