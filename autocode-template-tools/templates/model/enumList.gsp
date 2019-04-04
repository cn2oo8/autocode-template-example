className: ${data.className}
<%
    data.enumConstantDeclarationList.each { it ->
        print it.getName().toString() + '\t';
        def args = it.getArguments()
        println args[1].toString() + "\t" + args[0].toString();
    }


    def var1 = [
            haha : ''' hahaha ''',
            child: [
                    "name": 2
            ]


    ]
%>