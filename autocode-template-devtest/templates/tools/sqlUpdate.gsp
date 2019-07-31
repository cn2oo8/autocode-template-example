<%
    data.each { cellLine ->
        if (cellLine.size() < 1) {
            return
        }
%>
 update b2b_company_ext_info set `value`='1',concurrent_version = concurrent_version+1 where platform =2 and router='${cellLine.get(0)}' and original_company_id=${cellLine.get(0)} and `key`='model';
<%
    }
%>