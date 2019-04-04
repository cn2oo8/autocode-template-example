${snippetTemplateUtil.getTemplate('copyrightInfo')}
<%
    def varDomainName = tableNameUtil.lowerCaseFirst(tableDefine.id);
    def managerName = varDomainName + "Manager";
    def pkColumn = tableDefine.getPkColumn();
    def pkJavaType = tableNameUtil.getDataType(pkColumn?.columnType);
%>package ${config.basePackage}.sdk.service.test${PubUtils.addStrAfterSeparator(config.category, ".")}.testdata;

import ${config.basePackage}.sdk.domain${PubUtils.addStrAfterSeparator(config.category, ".")}.${tableDefine.id}Dto;
import java.util.ArrayList;
import java.util.List;
/**
 * ${tableDefine.cnname} 测试参数持有者
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
public class ${tableDefine.id}MockHolder {

    /**
     * 新增参数
     */
    private ${tableDefine.id}Dto addInfo;

    /**
     * 修改参数，应该先新增，然后在修改，最后删掉测试数据
     */
    private ${tableDefine.id}Dto updateInfo;

    /**
     * 测试期间添加的数据，测试完毕后需要清理
     */
    private List<${tableDefine.id}Dto> testPeriodDataList;


    public ${tableDefine.id}Dto getAddInfo() {
        return addInfo;
    }

    public void setAddInfo(${tableDefine.id}Dto addInfo) {
        this.addInfo = addInfo;
    }

    public ${tableDefine.id}Dto getUpdateInfo() {
        return updateInfo;
    }

    public void setUpdateInfo(${tableDefine.id}Dto updateInfo) {
        this.updateInfo = updateInfo;
    }


    public List<${tableDefine.id}Dto> getTestPeriodDataList() {
        return testPeriodDataList;
    }

    public void setTestPeriodDataList(List<${tableDefine.id}Dto> testPeriodDataList) {
        this.testPeriodDataList = testPeriodDataList;
    }

    public void addTestPeriodData(${tableDefine.id}Dto testData){
        if(testPeriodDataList==null){
            testPeriodDataList=new ArrayList<${tableDefine.id}Dto>();
        }
        testPeriodDataList.add(testData);
    }
    
}
