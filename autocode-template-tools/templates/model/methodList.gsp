<%
    //本模板用于获取Java源码中的方法+注释，并输出到控制台

    /
     *
     * 闭包，获取方法的注释信息
     */
    def getMethodComment = { javaDocComment ->
        def comment = "";
        if (javaDocComment.isPresent()) {
            comment = javaDocComment.get().getContent()
        }

        def commentLines = comment.split("\n");
        for (def commentLine in commentLines) {
            def cLine = commentLine.trim().replaceAll("\\*", "");
            if (cLine.length() > 1) {
                return cLine;
            }
        }
        return comment;
    }


    //遍历方法列表，并输出方法名称+注释
    data.methodDeclarationList.each { method ->
        def javaDocComment = method.getJavadocComment()
        def comment = getMethodComment(javaDocComment)
        println """${method.name}  (${comment})"""


    }
%>

