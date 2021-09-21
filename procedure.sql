use kino;
DROP procedure IF EXISTS `nbrCas`;
DROP procedure IF EXISTS `Ville`;
DROP procedure IF EXISTS `Police`;
delimiter $$

create  procedure nbrCas(OUT minYear int, OUT maxYear int)
begin
    DECLARE cnt INT DEFAULT 0 ;
    DECLARE max INT DEFAULT 0 ;
    DECLARE year int DEFAULT 0 ;
    DECLARE minYear int DEFAULT 50 ;
    DECLARE maxYear int DEFAULT 0 ;
    DECLARE counterYear int DEFAULT 0;
    DECLARE big int default 0 ;
    DECLARE min int default 50 ;
    

    create temporary table year select DISTINCT YEAR(Ertaussstrahlung) from folge ;
    
    select count(*) into max from year;
    WHILE cnt < max
    DO
        set year=(select * from year limit 1 offset cnt);
        set counterYear = (select count(*) from folge where Ertaussstrahlung >=CONCAT(year,'-','01','-','01') and Ertaussstrahlung < CONCAT((year + 1),'-','01','-','01')) ;
        IF counterYear > big
        THEN
            set big = counterYear;
            set maxYear = year;
        END IF;
        IF counterYear < min
        then
            set min = counterYear;
            set minYear = year;
        END IF;
    
        SET cnt=cnt+1;
    END WHILE;
    select minYear,maxYear;
    drop table year;
END;

$$
