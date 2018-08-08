<template>
    <div>
        <el-header>
            <h5>jujin8待审核文章管理</h5>
            <div style="overflow: hidden">
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
        RadioButton
    } from 'element-ui';

    Vue.use(Table);
    Vue.use(TableColumn);
    Vue.use(Radio);
    Vue.use(RadioGroup);
    Vue.use(RadioButton);
    export default {
        name: "article-need-look",
        data() {
            return {
                radio: "全部",
            }
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
            changeState(row, index) {
                console.log(row, index, "nnnn")
            },
            filterData(state) {
                console.log(state)
            }
        }
    }
</script>

<style scoped>

</style>