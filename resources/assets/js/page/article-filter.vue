<template>
    <div>
        <el-header>
            <h5>jujin8文章来源审核开关</h5>
        </el-header>
        <el-main>
            <template>
                <el-table
                        ref="multipleTable"
                        :data="tableData3"
                        tooltip-effect="dark"
                        style="width: 100%"
                        border
                        stripe
                        @selection-change="handleSelectionChange">
                    <el-table-column
                            type="selection"
                            width="55">
                    </el-table-column>
                    <el-table-column
                            :label="columns['time']['title']"
                            v-if="columns['time']['show']"
                            width="120">
                        <template slot-scope="scope">{{ scope.row.date }}</template>
                    </el-table-column>
                    <el-table-column
                            prop="name"
                            :label="columns['site']['title']"
                            v-if="columns['site']['show']"
                            width="120">
                    </el-table-column>
                    <el-table-column
                            :label="columns['state']['title']"
                            v-if="columns['state']['show']"
                            min-width="200">
                        <template slot-scope="scope">
                            <div :class="scope.row.state==0?'green':'red'">
                                {{scope.row.state==0?"自动审核":"人工审核"}}
                            </div>

                        </template>
                    </el-table-column>
                    <el-table-column
                            label="操作"
                            min-width="200">
                        <template slot-scope="scope">
                            <el-button
                                    size="mini"
                                    :type="scope.row.state?'success':'danger'"
                                    :disabled="!user_module_permission['article-filter-delete']"
                                    @click="changeState(scope.row,scope.$index)">{{scope.row.state==1?"修改为自动审核":"修改为人工审核"}}</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </template>
            <el-row style="margin-top: 20px">
            <el-button type="danger" round>批量修改为人工审核</el-button>
            <el-button type="success" round>批量修改为自动审核</el-button>
             </el-row>
        </el-main>
    </div>
</template>

<script>
    import {
        Table,
        TableColumn,
    } from 'element-ui';

    Vue.use(Table);
    Vue.use(TableColumn);
    import {mapState, mapActions, mapMutations, mapGetters} from 'vuex'

    export default {
        name: "article-filter",
        data() {
            return {
                tableData3: [{
                    date: '2016-05-03',
                    name: 'jin10',
                    state:1
                }, {
                    date: '2016-05-02',
                    name: 'jin10',
                    state:0
                }, {
                    date: '2016-05-04',
                    name: 'jin10',
                    state:1
                }, {
                    date: '2016-05-01',
                    name: 'jin10',
                    state:1
                }],
                multipleSelection: []
            }
        },
        computed: {
            ...mapState(['formLabelWidth']),
            ...mapState({
                'columns': state => state.article_filter.columns,
                'lists': state => state.article_filter.lists,
                'user_module_permission': state => state.user.user_module_permission
            })
        },
        methods: {
            ...mapMutations({
                // 'set_state':'menu/set_state',
                // 'set_feed_state': "menu/set_feed_state",
                // 'filter_data':"menu/filter_data"
            }),
            ...mapActions({
                // 'get_lists': 'menu/get_lists',
                // 'add_update':'menu/add_update'
            }),
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            changeState(row,index){
                console.log(row,index,"nnnn")
            }
        }
    }

</script>

<style scoped>
.red{
    color: #f56c6c;
}
.green{
    color: #67c23a;
}
</style>