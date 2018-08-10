<template>
    <div>
        <el-header>
            <h5>jujin8待审核文章管理</h5>
            <div style="overflow: hidden">
                <template>
                    <el-select v-model="value" placeholder="请选择网站来源" filterable  style="float: right;">
                        <el-option
                                v-for="item in options"
                                :key="item.value"
                                :label="item.label"
                                :value="item.value">
                        </el-option>
                    </el-select>
                </template>
                <!--<el-radio-group v-model="radio" style="float: right;" @change="filterData">-->
                    <!--<el-radio-button label="全部"></el-radio-button>-->
                    <!--<el-radio-button label="自动审核"></el-radio-button>-->
                    <!--<el-radio-button label="人工审核"></el-radio-button>-->
                <!--</el-radio-group>-->
            </div>
        </el-header>
        <el-main>
            article-need-look
        </el-main>
    </div>
</template>

<script>
    import {mapState, mapActions, mapMutations, mapGetters} from 'vuex'
    import {
        Table,
        TableColumn,
        Radio,
        RadioGroup,
        RadioButton,
        Select,
        Option
    } from 'element-ui';

    Vue.use(Table);
    Vue.use(TableColumn);
    Vue.use(Radio);
    Vue.use(RadioGroup);
    Vue.use(RadioButton);
    Vue.use(Select);
    Vue.use(Option);
    export default {
        name: "article-need-look",
        data() {
            return {
                radio: "全部",
                options: [{
                    value: '选项1',
                    label: '黄金糕'
                }, {
                    value: '选项2',
                    label: '双皮奶'
                }, {
                    value: '选项3',
                    label: '蚵仔煎'
                }, {
                    value: '选项4',
                    label: '龙须面'
                }, {
                    value: '选项5',
                    label: '北京烤鸭'
                }],
                value: 'jin10'
            }
        },
        computed:{
            ...mapState(['formLabelWidth']),
            ...mapState({
                'options':state =>state.article_need_look.options,
                // 'columns': state => state.article_filter.columns,
                // 'lists': state => state.article_filter.lists,
                // 'user_module_permission': state => state.user.user_module_permission
            })
        },
        methods: {
            ...mapMutations({
                // 'set_state':'menu/set_state',
                // 'set_feed_state': "menu/set_feed_state",
                // 'filter_data':"menu/filter_data"
            }),
            ...mapActions({
                'get_options':'article_need_look/get_options'
                // 'get_lists': 'menu/get_lists',
                // 'add_update':'menu/add_update'
            }),
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            changeState(row, index) {
                console.log(row, index, "nnnn")
            },
            filterData(state) {
                console.log(state)
            }
        },
        mounted(){
            this.get_options()
        }
    }
</script>

<style scoped>

</style>