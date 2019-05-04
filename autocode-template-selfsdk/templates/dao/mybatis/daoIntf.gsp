<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def pkColumn=tableDefine.getPkColumn();
  def pkJavaType=tableNameUtil.getDataType(pkColumn?.columnType);
%>package ${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,"." )};

import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )}.${tableDefine.id};
import ${config.basePackage}.dao.BaseDao;
import java.util.List;
import java.util.Map;

/**
 * ${tableDefine.cnname} Dao接口类
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
public interface ${tableDefine.id}Dao extends BaseDao<${tableDefine.id}> {
 
    /***
     * 根据主键，获取到明细
     * @param id
     * @return
     */
    @Override
    ${tableDefine.id} getByPk(Long id);

    /***
     * 条件查询,最大1000条
     * @param params
     * @return
     */
     @Override
    List<${tableDefine.id}> getListByExample(Map<String, Object> params);

    /***
     * 分页条件查询
     * @param params
     * @return
     */
     @Override
    List<${tableDefine.id}> queryByPage(Map<String, Object> params);

    /***
     * 分页查询行数，一定要传入分页信息
     * @param params
     * @return
     */
     @Override
    Long count(Map<String, Object> params);

    /***
     * 修改数据
     * @param obj
     * @return
     */
     @Override
    int update(${tableDefine.id} obj);


    /***
     * 添加数据
     * @param obj
     * @return
     */
     @Override
     int add(${tableDefine.id} obj);

    /**
     * 批量添加
     *
     * @param list
     * @return
     */
     @Override
    int batchAdd(List<${tableDefine.id}> list);

    /**
     * 物理删除，仅供测试清理数据
     */
     @Override
    int deleteByPk(Long id);

}
