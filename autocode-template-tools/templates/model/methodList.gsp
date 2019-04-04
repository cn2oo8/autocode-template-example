<%


    def getMehtodComment = { javaDocComment ->
        def comment = "";
        if (javaDocComment.isPresent()) {
            comment = javaDocComment.get().getContent()
        }

        def commentLines = comment.split("\n");
        for(def commentLine in commentLines){
            def cLine = commentLine.trim().replaceAll("\\*", "");
            if (cLine.length() > 1) {
                return cLine;
            }
        }
        return comment;
    }



    data.methodDeclarationList.each { method ->
        def javaDocComment = method.getJavadocComment()
        def comment = getMehtodComment(javaDocComment)
        println """${method.name}  (${comment})"""


    }
%>

