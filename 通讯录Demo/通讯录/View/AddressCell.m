//
//  AddressCell.m
//  通讯录Demo
//
//  Created by yeqiang on 2017/3/10.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "AddressCell.h"

@interface AddressCell ()

@property (nonatomic, strong) UIView *lineView;         //分割线
@property (nonatomic, strong) UIImageView *iconImage;   //头像
@property (nonatomic, strong) UILabel *labName;         //名字
@property (nonatomic, strong) UILabel *labState;        //状态文本
@property (nonatomic, strong) UIButton *btnState;       //状态按钮
@property (nonatomic, strong) UIButton *btnInvite;       //状态按钮

@end

@implementation AddressCell

#pragma mark - life cycle
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
        [self setAutoFrame];
    }
    return self;
}

- (void)setUI {
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.labName];
    [self.contentView addSubview:self.btnState];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.labState];
    [self.contentView addSubview:self.btnInvite];
}

- (void)setAutoFrame {
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@0.5);
    }];
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.height.equalTo(@40);
        make.width.equalTo(_iconImage.mas_height);
    }];
    
    [self.btnState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@54);
        make.height.equalTo(@29);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.iconImage.mas_right).offset(12);
        make.right.equalTo(self.btnState.mas_left).offset(-10);
    }];
    
    [self.labState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    [self.btnInvite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.width.equalTo(@24);
        make.height.equalTo(@24);
    }];
    
}

- (void)loadDataWith:(PPPersonModel *)model {
    if (_model != model) {
        _model = model;
        self.iconImage.image = _model.headerImage;
        self.statues = _model.statues;
        if (model.headerImage == nil) {
            [self.iconImage sd_setImageWithURL:[NSURL URLWithString:@"http://b.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=f0c5c08030d3d539c16807c70fb7c566/8ad4b31c8701a18bbef9f231982f07082838feba.jpg"] placeholderImage:[UIImage imageNamed:@"ic-选择框单选选中"]];
        }
        self.labName.text = _model.name;
        self.isInvite = _model.isInvite;
        
        if (_cellType == AddressCellTypeDefault) {
            self.btnInvite.hidden = YES;
            [self setViewIsHidenOrNot:self.statues];
        } else if (_cellType == AddressCellTypeInvite) {
            self.btnState.hidden = YES;
            self.labState.hidden = YES;
            self.btnInvite.selected = self.isInvite;
        }
    }
}

- (void)setViewIsHidenOrNot:(AddressStatues)statues {
    switch (statues) {
        case kAddressStatuesNone:
        {
            self.btnState.hidden = YES;
            self.labState.hidden = YES;
        }
            break;
        case kAddressStatuesMobile:
        {
            self.btnState.hidden = YES;
            self.labState.hidden = YES;
        }
            break;
        case kAddressStatuesNew:
        {
            self.btnState.hidden = YES;
            self.labState.hidden = YES;
        }
            break;
        case kAddressStatuesAdd:
        {
            self.btnState.hidden = NO;
            self.labState.hidden = YES;
            [self.btnState setTitle:@"加好友" forState:UIControlStateNormal];
        }
            break;
        case kAddressStatuesWait:
        {
            self.btnState.hidden = YES;
            self.labState.hidden = NO;
            self.labState.text = @"等待验证";
        }
            break;
        case kAddressStatuesAccept:
        {
            self.btnState.hidden = NO;
            self.labState.hidden = YES;
            [self.btnState setTitle:@"接受" forState:UIControlStateNormal];
        }
            break;
        case kAddressStatuesDone:
        {
            self.btnState.hidden = YES;
            self.labState.hidden = NO;
            self.labState.text = @"已添加";
        }
            break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)btnStateAction:(UIButton *)sender {
    if (_addressCellDelegate && [_addressCellDelegate respondsToSelector:@selector(addressCellDidSelected:)]) {
        [_addressCellDelegate addressCellDidSelected:self.model];
    }
}

- (void)btnInviteAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_addressCellDelegate && [_addressCellDelegate respondsToSelector:@selector(btnInviteSelected:model:)]) {
        [_addressCellDelegate btnInviteSelected:sender.selected model:self.model];
    }
}

- (void)setCellType:(AddressCellType)cellType {
    _cellType = cellType;
}

#pragma mark - setter and getter
- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _iconImage;
}

- (UILabel *)labName {
    if (!_labName) {
        _labName = [[UILabel alloc] initWithFrame:CGRectZero];
        _labName.textColor = [UIColor blackColor];
        _labName.font = [UIFont systemFontOfSize:14];
    }
    return _labName;
}

- (UIButton *)btnState {
    if (!_btnState) {
        _btnState = [[UIButton alloc] initWithFrame:CGRectZero];
        _btnState.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnState.backgroundColor = [UIColor redColor];
        _btnState.layer.cornerRadius = 4.0;
        _btnState.layer.masksToBounds = YES;
        _btnState.tintAdjustmentMode = YES;
        _btnState.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_btnState setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnState setBackgroundColor:[UIColor orangeColor]];
        [_btnState addTarget:self action:@selector(btnStateAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnState;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor blackColor];
    }
    return _lineView;
}

- (UILabel *)labState {
    if (!_labState) {
        _labState = [[UILabel alloc] init];
        _labState.backgroundColor = [UIColor whiteColor];
        _labState.textColor = [UIColor grayColor];
        _labState.font = [UIFont systemFontOfSize:12];
    }
    return _labState;
}

- (UIButton *)btnInvite {
    if (!_btnInvite) {
        _btnInvite = [[UIButton alloc] initWithFrame:CGRectZero];
        [_btnInvite addTarget:self action:@selector(btnInviteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnInvite setBackgroundImage:[UIImage imageNamed:@"ic-选择框多选选中"] forState:UIControlStateHighlighted];
        [self.btnInvite setBackgroundImage:[UIImage imageNamed:@"ic-选择框多选选中"] forState:UIControlStateSelected];
        [self.btnInvite setBackgroundImage:[UIImage imageNamed:@"ic-选择框单选"] forState:UIControlStateNormal];
    }
    return _btnInvite;
}

@end

#pragma mark - ABCAddressHeader

@interface ABCAddressHeader ()

@property (nonatomic, strong) UILabel *labTitle;

@end

@implementation ABCAddressHeader

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"header";
    ABCAddressHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!header) {
        header = [[ABCAddressHeader alloc] initWithReuseIdentifier:identifier];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.labTitle];
        [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.width.equalTo(@50);
        }];
    }
    return self;
}

- (UILabel *)labTitle {
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        _labTitle.tintColor = [UIColor yellowColor];
        _labTitle.font = [UIFont systemFontOfSize:12];
    }
    return _labTitle;
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
        self.labTitle.text = _title;
    }
}

@end

#pragma mark - AddressHeaderView

@interface AddressHeaderView ()

@property (nonatomic, strong) UILabel *labCount;
@property (nonatomic, assign) CGFloat width;

@end

@implementation AddressHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    UIView *view1 = [self addViewImage:@"ic-朋友添加" title:@"添加手机联系人" type:HeaderTypeAdd];
    UIView *view2 = [self addViewImage:@"ic-朋友新的" title:@"新的朋友" type:HeaderTypeNew];
    [self addSubview:self.labCount];
    
    __weak typeof(self) weakSelf = self;
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(self) strongSelf = weakSelf;
        make.top.equalTo(strongSelf).offset(4);
        make.left.right.equalTo(strongSelf);
        make.height.equalTo(@54);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(self) strongSelf = weakSelf;
        make.top.equalTo(view1.mas_bottom);
        make.left.right.equalTo(strongSelf);
        make.height.equalTo(@54);
    }];
    
    [self.labCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view2.mas_centerY);
        make.right.equalTo(view2.mas_right).offset(-39);
        make.height.equalTo(@18);
        make.width.greaterThanOrEqualTo(_labCount.mas_height);
    }];
}

- (UIView *)addViewImage:(NSString *)imageStr title:(NSString *)title type:(HeaderType)type {
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectZero];
    baseView.backgroundColor = [UIColor whiteColor];
    baseView.tag = type;
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    headImage.image = [UIImage imageNamed:imageStr];
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    
    labTitle.text = title;
    labTitle.textColor = [UIColor blackColor];
    labTitle.font = [UIFont systemFontOfSize:14];
    
    UIImageView *imgArrows = [[UIImageView alloc] initWithFrame:CGRectZero];
    imgArrows.image = [UIImage imageNamed:@"ic-箭头28浅灰"];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = [UIColor grayColor];
    
    [self addSubview:baseView];
    [baseView addSubview:headImage];
    [baseView addSubview:labTitle];
    [baseView addSubview:lineView];
    [baseView addSubview:imgArrows];
    
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@54);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(baseView.mas_centerY);
        make.left.equalTo(baseView.mas_left).offset(15);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];
    
    [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(baseView.mas_centerY);
        make.left.equalTo(headImage.mas_right).offset(12);
    }];
    
    [imgArrows mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headImage.mas_centerY);
        make.right.equalTo(baseView.mas_right).offset(-15);
        make.width.equalTo(@14);
        make.height.equalTo(imgArrows.mas_width);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(baseView);
        make.height.equalTo(@0.5);
    }];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:tap];
    
    return baseView;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    NSLog(@"%ld", tap.view.tag);
    HeaderType type = tap.view.tag;
    if (_delegate && [_delegate respondsToSelector:@selector(addressHeaderViewSelected:)]) {
        [_delegate addressHeaderViewSelected:type];
    }
}

#pragma public
- (void)setNewCount:(NSInteger)newCount {
    self.labCount.hidden = (newCount == 0) ? YES : NO;
    self.labCount.text = [NSString stringWithFormat:@"%ld", newCount];
}

- (UILabel *)labCount {
    if (!_labCount) {
        _labCount = [[UILabel alloc] init];
        _labCount.layer.cornerRadius = 9.0;
        _labCount.layer.masksToBounds = YES;
        _labCount.backgroundColor = [UIColor redColor];
        _labCount.textColor = [UIColor whiteColor];
        _labCount.font = [UIFont systemFontOfSize:12];
        _labCount.textAlignment = NSTextAlignmentCenter;
        _labCount.hidden = YES;
    }
    return _labCount;
}

@end

#pragma mark - AddressSearchBar

@interface AddressSearchBar ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImage *textIcon;
@property (nonatomic, strong) UIButton *btnCancel;

@end

@implementation AddressSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self addSubview:self.textField];
    [self addSubview:self.btnCancel];
}

#pragma mark - public
- (void)setTextIcon:(UIImage *)textIcon {
    
}

#pragma mark - setter and getter
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.layer.cornerRadius = 14.0;
        _textField.clipsToBounds = YES;
    }
    return _textField;
}
//- (UIImage *)textIcon {
//    if () {
//        _textIcon = [[UIImage alloc] init];;
//    }
//    return _textIcon;
//}

@end


