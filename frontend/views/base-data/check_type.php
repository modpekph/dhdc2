<?php
$this->params['breadcrumbs'][] = ['label' => 'ข้อมูลพื้นฐาน', 'url' => ['base-data/index']];
$this->params['breadcrumbs'][] ='ประเภทการอยู่อาศัย';
?>

<a href="#" id="btn_sql">ชุดคำสั่ง</a>
<div id="sql" style="display: none"><?= $sql ?></div>

<?php
if (isset($dataProvider))
//echo yii\grid\GridView::widget([
    echo \kartik\grid\GridView::widget([
        'dataProvider' => $dataProvider,
       'formatter' => ['class' => 'yii\i18n\Formatter', 'nullDisplay' => ''],
        'hover' => true,
        'floatHeader' => true,
        'panel' => [
            'before' => '',
            'type' => \kartik\grid\GridView::TYPE_SUCCESS,
            'after' => 'โดย '. \yii\helpers\Html::a('คุณศรศักดิ์ สีหะวงษ์', 'https://fb.com/sosplk',['target'=>'_blank'])
        ],
    ]);
?>
<?php
$script = <<< JS
$('#btn_sql').on('click', function(e) {
    
   $('#sql').toggle();
});
JS;
$this->registerJs($script);
?>




