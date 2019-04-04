
dlkldfjkjkdfjdfjdf

<%
    try {
        def ctx = data;
        def isDelete = false;
        def userLevelInfo = ["level": 61]
        def relId = 2;
        if (ctx._source.userLevelInfoList == null) {
            def newList = [userLevelInfo]; ctx._source.userLevelInfoList = newList;
            println JSON.toJSONString(ctx);
            return;
        }
        Boolean isAdd = true; for (int i = 0; i < ctx._source.userLevelInfoList.size(); i++) {
            if (ctx._source.userLevelInfoList.get(i)['relId'] == relId) {
                isAdd = false; if (isDelete) {
                    ctx._source.userLevelInfoList.remove(i);
                } else {
                    ctx._source.userLevelInfoList.set(i, userLevelInfo);
                }
            }
        };
        if (isAdd && !isDelete) {
            ctx._source.userLevelInfoList.add(userLevelInfo);
        }
    } catch (Exception e) {
        e.printStackTrace();
        println e;
    }
%>
println JSON.toJSONString(ctx);
