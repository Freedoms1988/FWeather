//
//  FWViewController.m
//  FWeather
//
//  Created by Freedoms on 13-7-1.
//  Copyright (c) 2013年 Freedoms. All rights reserved.
//
#import "FWViewController.h"

#define CGRECT_SEGMENT CGRectMake(5.0f,5.0f,310.0f,44.0f)
#define CGRECT_SENDBUTTON CGRectMake(5.0f,54.0f,310.0f,44.0f)
//#define CGRECT_CITYPICKER CGRectMake(0.0f,self.view.bounds.size.height-260.0f,320.0f,300.0f)
#define CGRECT_SCROLLVIEW CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)

#define CGRECT_CITY_LABEL CGRectMake(5.0f,102.0f,150.0f,44.0f)
#define CGRECT_CITY CGRectMake(160.0f,102.0f,150.0f,44.0f)

#define CGRECT_CITYCODE_LABEL CGRectMake(5.0f,151.0f,150.0f,44.0f)
#define CGRECT_CITYCODE CGRectMake(160.0f,151.0f,150.0f,44.0f)

#define CGRECT_DATE_LABEL CGRectMake(5.0f,200.0f,150.0f,44.0f)
#define CGRECT_DATE CGRectMake(160.0f,200.0f,150.0f,44.0f)

#define CGRECT_WEATHER_LABEL CGRectMake(5.0f,249.0f,150.0f,44.0f)
#define CGRECT_WEATHER CGRectMake(160.0f,249.0f,150.0f,44.0f)

#define CGRECT_WEATHERIMG_LABEL CGRectMake(5.0f,298.0f,150.0f,44.0f)
#define CGRECT_WEATHERIMG CGRectMake(160.0f,298.0f,150.0f,44.0f)

#define CGRECT_TEMP_LABEL CGRectMake(5.0f,347.0f,150.0f,44.0f)
#define CGRECT_TEMP CGRectMake(160.0f,347.0f,150.0f,44.0f)

//#define kProvince 0
//#define kCity 1

#define SQL_CREATE_CITY_TABLE @"CREATE TABLE IF NOT EXISTS CITY_TABLE(PROVINCE_KEY TEXT,CITY_KEY TEXT,AREA_KEY TEXT,CITY_NAME TEXT,CITYCODE TEXT)"
#define SQL_INSERT_CITY @"INSERT INTO CITY_TABLE (PROVINCE_KEY,CITY_KEY,AREA_KEY,CITY_NAME,CITYCODE) VALUES(?,?,?,?,?)"
#define SQL_QUERY_CITY_PROVINCE @"SELECT PROVINCE_KEY,CITY_KEY,AREA_KEY,CITY_NAME,CITYCODE FROM CITY_TABLE"
#define SQL_QUERY_CITY_CITY @"SELECT PROVINCE_KEY,CITY_KEY,AREA_KEY,CITY_NAME,CITYCODE FROM CITY_TABLE WHERE PROVINCE_KEY=?"
#define SQL_QUERY_CITY_AREA @"SELECT PROVINCE_KEY,CITY_KEY,AREA_KEY,CITY_NAME,CITYCODE FROM CITY_TABLE WHERE CITY_KEY=?"
#define SQL_QUERY_CITY_CITYCODE @"SELECT PROVINCE_KEY,CITY_KEY,AREA_KEY,CITY_NAME,CITYCODE FROM CITY_TABLE WHERE AREA_KEY=?"
#define SQL_UPDATE_CITY @"UPDATE CITY_TABLE SET PROVINCE_KEY=?,CITY_KEY=?,AREA_KEY=?,CITY_NAME=?,CITYCODE=? WHERE CITY_NAME=?"

#define URL_MAIN @"http://m.weather.com.cn/data5/city"
#define URL_XML @".xml"
@interface FWViewController ()
{
    UISegmentedControl *_modeSegmentedControl;
    UIPickerView *_cityPicker;
    UIButton *_sendButton;
    UIScrollView *_scrollView;
    
    UILabel *_cityLabel;
    UILabel *_cityCodeLabel;
    UILabel *_tempTextLabel;
    UILabel *_dateLabel;
    UILabel *_weatherLabel;
    UILabel *_weatherImageLabel;
    
    UILabel *_cityText;
    UILabel *_cityCodeText;
    UILabel *_tempText;
    UILabel *_dateText;
    UILabel *_weatherText;
    UIImageView *_weatherImageView;
}
@end

@implementation FWViewController
#pragma mark - ViewController LifeCircle
- (void)viewDidLoad
{
    [self initUI];
    [self initData];
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UIAction
-(void) sendAction
{
    
}

-(void) modeAction
{
}

-(void) updateAction
{
    
}



#pragma mark - init
-(void) initData
{
    
}

-(void) initUI
{
    self.title = @"天气预报";
    
	UIBarButtonItem *updateDataButton=[[UIBarButtonItem alloc]initWithTitle:@"更新数据" style:UIBarButtonItemStylePlain target:self action:@selector(updateAction)];
	self.navigationItem.rightBarButtonItem=updateDataButton;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRECT_SCROLLVIEW];
    [self.view addSubview:_scrollView];
    
    _modeSegmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRECT_SEGMENT];
    [_modeSegmentedControl insertSegmentWithTitle:@"实时天气" atIndex:0 animated:YES];
    [_modeSegmentedControl insertSegmentWithTitle:@"7天预报" atIndex:1 animated:YES];
    [_modeSegmentedControl insertSegmentWithTitle:@"今天天气" atIndex:2 animated:YES];
    [_modeSegmentedControl addTarget:self action:@selector(modeAction) forControlEvents:UIControlEventValueChanged];
    [_scrollView addSubview:_modeSegmentedControl];
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _sendButton.frame = CGRECT_SENDBUTTON;
    [_sendButton setTitle:@"发送请求" forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_sendButton];
    
    _cityLabel = [[UILabel alloc] initWithFrame:CGRECT_CITY_LABEL];
    _cityLabel.text = @"城市名称";
    [_scrollView addSubview:_cityLabel];
    
    _cityText = [[UILabel alloc] initWithFrame:CGRECT_CITY];
    _cityText.text = @"城市";
    [_scrollView addSubview:_cityText];
    
    _cityCodeLabel = [[UILabel alloc] initWithFrame:CGRECT_CITYCODE_LABEL];
    _cityCodeLabel.text = @"城市编号";
    [_scrollView addSubview:_cityCodeLabel];
    
    _cityCodeText = [[UILabel alloc] initWithFrame:CGRECT_CITYCODE];
    _cityCodeText.text = @"城市编号";
    [_scrollView addSubview:_cityCodeText];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRECT_DATE_LABEL];
    _dateLabel.text = @"日期";
    [_scrollView addSubview:_dateLabel];
    
    _dateText = [[UILabel alloc] initWithFrame:CGRECT_DATE];
    _dateText.text = @"日期";
    [_scrollView addSubview:_dateText];
    
    _weatherLabel = [[UILabel alloc] initWithFrame:CGRECT_WEATHER_LABEL];
    _weatherLabel.text = @"天气";
    [_scrollView addSubview:_weatherLabel];
    
    _weatherText = [[UILabel alloc] initWithFrame:CGRECT_WEATHER];
    _weatherText.text = @"天气";
    [_scrollView addSubview:_weatherText];
    
    _tempTextLabel = [[UILabel alloc] initWithFrame:CGRECT_TEMP_LABEL];
    _tempTextLabel.text = @"温度";
    [_scrollView addSubview:_tempTextLabel];
    
    _tempText = [[UILabel alloc] initWithFrame:CGRECT_TEMP];
    _tempText.text = @"温度";
    [_scrollView addSubview:_tempText];
    
    _weatherImageLabel = [[UILabel alloc] initWithFrame:CGRECT_WEATHERIMG_LABEL];
    _weatherImageLabel.text = @"天气图片";
    [_scrollView addSubview:_weatherImageLabel];
    
    _weatherImageView = [[UIImageView alloc] initWithFrame:CGRECT_WEATHERIMG];
    
    [_scrollView addSubview:_weatherImageView];
    
//    _cityPicker = [[UIPickerView alloc] initWithFrame:CGRECT_CITYPICKER];
//    _cityPicker.dataSource = self;
//    _cityPicker.delegate = self;
//    [_scrollView addSubview:_cityPicker];
//    [_cityPicker setHidden:YES];
}
#pragma mark - delegate

@end

