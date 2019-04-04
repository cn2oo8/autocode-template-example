<%
    def format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
    def startFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH")
    Date startDateTime = format.parse("2018-10-25 09:00:00")

    def transList =[]

   def rowCount =data.size();
   data.eachWithIndex{ it, outIndex->
       it.eachWithIndex{ column, index ->
           if(index%3 ==0) {
               def subList = transList[outIndex];
               if(subList == null) {
                   subList =[];
                   transList[outIndex] = subList;
               }
               subList.add(column);
           }
       }
   }

    def columnCount = transList[0].size();

    def joinColumn = { list, index ->
        def newList= [];
        rowCount.times{it->
           newList[it] = list[it][index];
        }
        return StringUtils.join(newList,",");
    }


    def dutyMap = [:]
    columnCount.times{ it->
        Date newDate = new Date(startDateTime.getTime() + (12*3600*1000*it));
        def startTime = startFormat.format(newDate)
        dutyMap.put(startTime, joinColumn(transList, it))
    }

    println JSON.toJSONString(dutyMap);
%>