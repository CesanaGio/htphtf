------
create table htptemp
(
    SESSIONID number not null,
    LINE varchar2(1024)    
)
create index htptempIX1 on htptemp (SESSIONID)

------
create or replace package htp as
    procedure add(t varchar2);
    procedure p(t varchar2);
    procedure print(t varchar2);
    procedure htmlOpen;
    procedure htmlClose;
end htp;
------
create or replace package body htp as

    ---------
    procedure add(t varchar2) is
    begin
        insert into htptemp (SESSIONID,LINE) values (sys_context('userenv','sid'),t);
    end;
    ---------
    procedure p(t varchar2) is
    begin
        add(t);
    end;
    ---------
    procedure print(t varchar2) is
    begin
        add(t);
    end;
    ---------
    procedure htmlOpen is
    begin
        add('<html>');
    end;
    ---------
    procedure htmlClose is
    begin
        add('</html>');
    end;

end htp;
------
create or replace package htf as
    function bold(t varchar2, a varchar2) return varchar2;
end htf;
------
create or replace package body htf as
    --------
    function bold(t varchar2, a varchar2) return varchar2 is
    begin
        return('<b '||a||'>'||t||'</b>');
    end;
end htf;
------
create or replace procedure testingHTP() as
begin
    htp.htmlOpen;
    htp.p('Hello World!');
    htp.htmlClose;    
end;

