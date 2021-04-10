drop procedure if exists bfs;

create procedure bfs(id bigint)
    begin
        declare curr bigint;
        create temporary table queue (node_id bigint);
        create temporary table visited(node_id bigint);

        insert into queue(node_id) value (id);

        while( select exists(select 1 from queue) ) <> 0 do
            set curr = (select node_id from queue limit 1);
            delete from queue as qu where qu.node_id = curr;
            insert into visited(node_id) value (curr);

            insert into queue ( select el.des from edge_list el where el.src = curr and el.des not in (select vs.node_id from visited as vs) );

        end while;

        select * from visited;
        drop table queue;
        drop table visited;
    end;


call bfs(6);
