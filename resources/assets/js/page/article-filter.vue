<template>
    <div>
        <el-header>
            <h5>jujin8文章来源审核开关</h5>
            <div style="overflow: hidden">
                <el-radio-group v-model="radio" style="float: right;" @change="filterData">
                    <el-radio-button label="全部"></el-radio-button>
                    <el-radio-button label="自动审核"></el-radio-button>
                    <el-radio-button label="人工审核"></el-radio-button>
                </el-radio-group>
            </div>

        </el-header>
        <el-main>
            <template>
                <el-table
                        ref="multipleTable"
                        :data="lists"
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
                        <template slot-scope="scope">{{ scope.row.time }}</template>
                    </el-table-column>
                    <el-table-column
                            prop="source_site"
                            :label="columns['site']['title']"
                            v-if="columns['site']['show']"
                            width="200">
                    </el-table-column>
                    <el-table-column
                            :label="columns['state']['title']"
                            v-if="columns['state']['show']"
                            width="120">
                        <template slot-scope="scope">
                            <div :class="scope.row.state?'red':'green'">
                                {{scope.row.state?"人工审核":"自动审核"}}
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
        Radio,
        RadioGroup,
        RadioButton
    } from 'element-ui';

    Vue.use(Table);
    Vue.use(TableColumn);
    Vue.use(Radio);
    Vue.use(RadioGroup);
    Vue.use(RadioButton);
    import {mapState, mapActions, mapMutations, mapGetters} from 'vuex'

    export default {
        name: "article-filter",
        data() {
            return {
                radio:"全部",
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
                'filter_data':"article_filter/filter_data"
            }),
            ...mapActions({
                'get_lists': 'article_filter/get_lists',
                // 'add_update':'menu/add_update'
            }),
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            changeState(row,index){
                console.log(row,index,"nnnn")
            },
            filterData(state){
                let param="";
                switch (state){
                    case "全部":param=0;break;
                    case "自动审核":param=1;break;
                    case "人工审核":param=2;break;
                }

                this.filter_data(param);
            }
        },
        mounted(){
            this.get_lists().then(result=> {
                this.$message.success('成功获取文章所有来源！');
            }).catch((ErrMsg)=>{
                this.$message.error('获取数据失败，请刷新此页！');
                //获取数据失败时的处理逻辑
            })
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