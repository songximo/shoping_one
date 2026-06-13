// pages/AddressPage.ets
// import { router, promptAction } from '@kit.ArkUI';
// import { AddressInfo, loadAddresses, deleteAddress, addAddress } from '../../models/AddressData';
//
// @Entry
// @Component
// struct AddressPage {
//   @State addressList: AddressInfo[] = [];
//   @State showAddDialog: boolean = false;
//   @State newAddress: AddressInfo = new AddressInfo();
//
//   aboutToAppear() {
//     this.refreshList();
//   }
//
//   // async refreshList() {
//   //   this.addressList = await loadAddresses();
//   // }
//   async refreshList() {
//     let list = await loadAddresses();
//     // 新添加的地址显示在列表底部
//     list.sort((a, b) => {
//       if (a.isDefault !== b.isDefault) {
//         return a.isDefault ? -1 : 1;
//       }
//       return a.id.localeCompare(b.id); // 新添加的 id 更大
//     });
//     this.addressList = list;
//   }
//
//
//   async handleDelete(id: string) {
//     AlertDialog.show({
//       title: '删除地址',
//       message: '确定要删除该地址吗？',
//       primaryButton: { value: '取消', action: () => {} },
//       secondaryButton: {
//         value: '删除',
//         fontColor: '#FF3B30',
//         action: async () => {
//           await deleteAddress(id);
//           await this.refreshList();
//         }
//       }
//     });
//   }
//
//   async handleSaveNewAddress() {
//     const name = this.newAddress.name;
//     const phone = this.newAddress.phone;
//     const province = this.newAddress.province;
//     const city = this.newAddress.city;
//     const district = this.newAddress.district;
//     const detail = this.newAddress.detail;
//
//     if (!name || !phone || !province || !city || !district || !detail) {
//       promptAction.showToast({ message: '请填写完整信息' });
//       return;
//     }
//     const phoneReg = /^1[3-9]\d{9}$/;
//     if (!phoneReg.test(phone)) {
//       promptAction.showToast({ message: '手机号格式不正确' });
//       return;
//     }
//     // 手动复制属性
//     const newAddr = new AddressInfo();
//     newAddr.name = name;
//     newAddr.phone = phone;
//     newAddr.province = province;
//     newAddr.city = city;
//     newAddr.district = district;
//     newAddr.detail = detail;
//     newAddr.isDefault = this.newAddress.isDefault;
//
//     await addAddress(newAddr);
//     await this.refreshList();
//     this.showAddDialog = false;
//     this.newAddress = new AddressInfo();
//   }
//
//   @Builder
//   AddressItemBuilder(addr: AddressInfo) {
//     Row() {
//       Column({ space: 4 }) {
//         Row({ space: 8 }) {
//           Text(addr.name).fontSize(16).fontWeight(500)
//           Text(addr.phone).fontSize(14).fontColor('#666')
//           Text(addr.province + ' ' + addr.city + ' ' + addr.district)
//           Text(addr.detail)
//           if (addr.isDefault) {
//             Text('默认').fontSize(10).fontColor('#FFF').backgroundColor('#FF5722')
//               .padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(10)
//           }
//         }
//         .width('100%')
//         Text(addr.fullAddress).fontSize(14).fontColor('#333')
//       }
//       .layoutWeight(1)
//       .alignItems(HorizontalAlign.Start)
//
//       Image($r('app.media.ic_public_delete'))
//         .width(20).height(20).fillColor('#FF3B30')
//         .margin({ left: 12 })
//         .onClick(() => this.handleDelete(addr.id))
//     }
//     .width('100%')
//     .padding(16)
//     .backgroundColor('#FFFFFF')
//     .borderRadius(8)
//     .margin({ bottom: 10 })
//   }
//
//   build() {
//     Stack() {
//       // 主内容
//       Column() {
//         // 头部栏
//         Row() {
//           Row() {
//             Image($r('app.media.ic_public_arrow_left'))
//               .width(24).height(24)
//           }
//           .width(44).height(44)
//           .justifyContent(FlexAlign.Center)
//           .onClick(() => router.back())
//
//           Text('收货地址')
//             .fontSize(20).fontWeight(FontWeight.Bold)
//             .layoutWeight(1)
//             .textAlign(TextAlign.Center)
//
//           Button('新增')
//             .fontSize(14)
//             .backgroundColor(Color.Transparent)
//             .fontColor('#007AFF')
//             .onClick(() => {
//               this.newAddress = new AddressInfo();
//               this.showAddDialog = true;
//             })
//         }
//         .width('100%')
//         .height(56)
//         .padding({ left: 12, right: 12 })
//         .backgroundColor('#FFFFFF')
//         .border({ width: { bottom: 0.5 }, color: '#E5E5E5' })
//
//         // 地址列表
//         Scroll() {
//           Column() {
//             if (this.addressList.length === 0) {
//               Text('暂无收货地址，点击“新增”添加')
//                 .fontSize(14).fontColor('#999')
//                 .margin({ top: 50 })
//                 .width('100%')
//                 .textAlign(TextAlign.Center)
//             } else {
//               ForEach(this.addressList, (item: AddressInfo) => {
//                 this.AddressItemBuilder(item)
//               }, (item: AddressInfo) => item.id)
//             }
//           }
//           .padding(12)
//           // .padding({ left: 12, right: 12, bottom: 12 })
//           .width('100%')
//           // .justifyContent(FlexAlign.Start)
//           // .alignItems(HorizontalAlign.Center)
//         }
//         .layoutWeight(1)
//       }
//       .width('100%')
//       .height('100%')
//       .backgroundColor('#F5F5F5')
//
//       // 新增地址对话框（浮层）
//       if (this.showAddDialog) {
//         Column() {
//           Column() {
//             Text('新增地址')
//               .fontSize(18).fontWeight(600)
//               .width('100%')
//               .textAlign(TextAlign.Center)
//               .margin({ bottom: 16 })
//
//             TextInput({ placeholder: '收货人姓名', text: this.newAddress.name })
//               .onChange(v => this.newAddress.name = v)
//               .margin({ bottom: 12 })
//             TextInput({ placeholder: '手机号码', text: this.newAddress.phone })
//               .onChange(v => this.newAddress.phone = v)
//               .margin({ bottom: 12 })
//             Row({ space: 8 }) {
//               TextInput({ placeholder: '省', text: this.newAddress.province })
//                 .layoutWeight(1).onChange(v => this.newAddress.province = v)
//               TextInput({ placeholder: '市', text: this.newAddress.city })
//                 .layoutWeight(1).onChange(v => this.newAddress.city = v)
//               TextInput({ placeholder: '区', text: this.newAddress.district })
//                 .layoutWeight(1).onChange(v => this.newAddress.district = v)
//             }
//             TextInput({ placeholder: '详细地址', text: this.newAddress.detail })
//               .onChange(v => this.newAddress.detail = v)
//               .margin({ top: 12 })
//
//             Row({ space: 12 }) {
//               Button('取消')
//                 .layoutWeight(1)
//                 .onClick(() => { this.showAddDialog = false; this.newAddress = new AddressInfo(); })
//               Button('保存')
//                 .layoutWeight(1)
//                 .backgroundColor('#007AFF')
//                 .onClick(() => this.handleSaveNewAddress())
//             }
//             .margin({ top: 20 })
//           }
//           .width('90%')
//           .padding(20)
//           .backgroundColor('#FFFFFF')
//           .borderRadius(16)
//         }
//         .width('100%')
//         .height('100%')
//         .justifyContent(FlexAlign.Center)
//         .alignItems(HorizontalAlign.Center)
//         .backgroundColor('rgba(0,0,0,0.5)')
//         .position({ x: 0, y: 0 })
//       }
//     }
//     .width('100%')
//     .height('100%')
//   }
// }


//优化结构
import { router, promptAction } from '@kit.ArkUI';
import { AddressInfo, loadAddresses, deleteAddress, addAddress, updateAddress } from '../../models/AddressData';

@Entry
@Component
struct AddressPage {
  @State addressList: AddressInfo[] = [];
  @State showAddDialog: boolean = false;
  @State newAddress: AddressInfo = new AddressInfo();
  @State showEditDialog: boolean = false;
  @State editingAddress: AddressInfo | null = null;  // 正在编辑的地址

  aboutToAppear() {
    this.refreshList();
  }

  async refreshList() {
    let list = await loadAddresses();
    //默认地址排最前，其余按 id 顺序，新增在下
    list.sort((a, b) => {
      if (a.isDefault !== b.isDefault) {
        return a.isDefault ? -1 : 1;
      }
      return a.id.localeCompare(b.id);//新增在下
    });
    this.addressList = list;
  }

  async handleDelete(id: string) {
    AlertDialog.show({
      title: '删除地址',
      message: '确定要删除该地址吗？',
      primaryButton: { value: '取消', action: () => {} },
      secondaryButton: {
        value: '删除',
        fontColor: '#FF3B30',
        action: async () => {
          await deleteAddress(id);
          await this.refreshList();
        }
      }
    });
  }

  async handleSaveNewAddress() {
    const name = this.newAddress.name;
    const phone = this.newAddress.phone;
    const province = this.newAddress.province;
    const city = this.newAddress.city;
    const district = this.newAddress.district;
    const detail = this.newAddress.detail;

    if (!name || !phone || !province || !city || !district || !detail) {
      promptAction.showToast({ message: '请填写完整信息' });
      return;
    }
    const phoneReg = /^1[3-9]\d{9}$/;
    if (!phoneReg.test(phone)) {
      promptAction.showToast({ message: '手机号格式不正确' });
      return;
    }

    const newAddr = new AddressInfo();
    newAddr.name = name;
    newAddr.phone = phone;
    newAddr.province = province;
    newAddr.city = city;
    newAddr.district = district;
    newAddr.detail = detail;
    newAddr.isDefault = this.newAddress.isDefault;

    await addAddress(newAddr);
    await this.refreshList();
    this.showAddDialog = false;
    this.newAddress = new AddressInfo();
  }


  // 打开编辑对话框
  openEditDialog(addr: AddressInfo) {
    // 手动深拷贝地址对象
    const copy = new AddressInfo();
    copy.id = addr.id;
    copy.name = addr.name;
    copy.phone = addr.phone;
    copy.province = addr.province;
    copy.city = addr.city;
    copy.district = addr.district;
    copy.detail = addr.detail;
    copy.isDefault = addr.isDefault;
    this.editingAddress = copy;
    this.showEditDialog = true;
  }

  // 保存编辑后的地址
  async handleSaveEditedAddress() {
    if (!this.editingAddress) return;
    // 单独获取每个属性
    const name = this.editingAddress.name;
    const phone = this.editingAddress.phone;
    const province = this.editingAddress.province;
    const city = this.editingAddress.city;
    const district = this.editingAddress.district;
    const detail = this.editingAddress.detail;
    const isDefault = this.editingAddress.isDefault;
    const id = this.editingAddress.id;

    if (!name || !phone || !province || !city || !district || !detail) {
      promptAction.showToast({ message: '请填写完整信息' });
      return;
    }
    const phoneReg = /^1[3-9]\d{9}$/;
    if (!phoneReg.test(phone)) {
      promptAction.showToast({ message: '手机号格式不正确' });
      return;
    }

    // 调用更新方法（确保 updateAddress 已导入）
    await updateAddress(this.editingAddress);
    await this.refreshList();
    this.showEditDialog = false;
    this.editingAddress = null;
    promptAction.showToast({ message: '地址修改成功' });
  }


  @Builder
  AddressItemBuilder(addr: AddressInfo) {
    Column() {
      // 第一行：姓名 + 电话 + 默认标签
      Row({ space: 8 }) {
        Text(addr.name).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#333333')
        Text(addr.phone).fontSize(14).fontColor('#666666')
        if (addr.isDefault) {
          Text('默认').fontSize(10)
            .fontColor('#FFFFFF').backgroundColor('#FF5722').padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(10)
        }
        Blank()
        // 编辑按钮
        Image($r('app.media.bianji'))
          .width(20).height(20)
          .fillColor('#007AFF')
          .margin({ right: 12 })
          .onClick(() => {
            this.openEditDialog(addr);
          })
        // 删除按钮
        Image($r('app.media.ic_public_delete')).width(20).height(20)
          .fillColor('#FF3B30')
          .onClick(() => this.handleDelete(addr.id))
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      // 第二行：省市区（完整显示）
      Text(`${addr.province} ${addr.city} ${addr.district}`)
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')
        .margin({ top: 8 })

      // 第三行：详细地址（完整显示，支持换行）
      Text(addr.detail)
        .fontSize(14)
        .fontColor('#333333')
        .width('100%')
        .margin({ top: 4 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .margin({ bottom: 12 })
    .justifyContent(FlexAlign.Start)
  }

  build() {
    Stack() {
      // 主内容
      Column() {
        // 头部栏
        Row() {
          Row() {
            Image($r('app.media.ic_public_arrow_left'))
              .width(24)
              .height(24)
          }
          .width(44)
          .height(44)
          .justifyContent(FlexAlign.Center)
          .onClick(() => router.back())

          Text('收货地址')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Button('新增')
            .fontSize(14)
            .backgroundColor(Color.Transparent)
            .fontColor('#007AFF')
            .onClick(() => {
              this.newAddress = new AddressInfo();
              this.showAddDialog = true;
            })
        }
        .width('100%')
        .height(56)
        .padding({ left: 12, right: 12 })
        .backgroundColor('#FFFFFF')
        .border({ width: { bottom: 0.5 }, color: '#E5E5E5' })

        // 地址列表
        Scroll() {
          Column() {
            if (this.addressList.length === 0) {
              Text('暂无收货地址，点击"新增"添加')
                .fontSize(14)
                .fontColor('#999999')
                .margin({ top: 50 })
                .width('100%')
                .textAlign(TextAlign.Center)
            } else {
              ForEach(this.addressList, (item: AddressInfo) => {
                this.AddressItemBuilder(item)
              }
                ,(item: AddressInfo) => `${item.id}_${item.isDefault}_${item.name}_${item.phone}_${item.province}_${item.city}_${item.district}_${item.detail}`)
            }
          }
          .padding(12)
          .width('100%')
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')

      // 新增地址对话框
      if (this.showAddDialog) {
        Column() {
          Column() {
            Text('新增地址')
              .fontSize(18)
              .fontWeight(600)
              .width('100%')
              .textAlign(TextAlign.Center)
              .margin({ bottom: 16 })

            TextInput({ placeholder: '收货人姓名', text: this.newAddress.name })
              .onChange(v => this.newAddress.name = v)
              .margin({ bottom: 12 })

            TextInput({ placeholder: '手机号码', text: this.newAddress.phone })
              .onChange(v => this.newAddress.phone = v)
              .margin({ bottom: 12 })

            Row({ space: 8 }) {
              TextInput({ placeholder: '省', text: this.newAddress.province })
                .layoutWeight(1)
                .onChange(v => this.newAddress.province = v)
              TextInput({ placeholder: '市', text: this.newAddress.city })
                .layoutWeight(1)
                .onChange(v => this.newAddress.city = v)
              TextInput({ placeholder: '区', text: this.newAddress.district })
                .layoutWeight(1)
                .onChange(v => this.newAddress.district = v)
            }

            TextInput({ placeholder: '详细地址', text: this.newAddress.detail })
              .onChange(v => this.newAddress.detail = v)
              .margin({ top: 12 })

            Row({ space: 12 }) {
              Button('取消')
                .layoutWeight(1)
                .onClick(() => {
                  this.showAddDialog = false;
                  this.newAddress = new AddressInfo();
                })
              Button('保存')
                .layoutWeight(1)
                .backgroundColor('#007AFF')
                .onClick(() => this.handleSaveNewAddress())
            }
            .margin({ top: 20 })
          }
          .width('90%')
          .padding(20)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('rgba(0,0,0,0.5)')
        .position({ x: 0, y: 0 })
      }

      //编辑对话框
      if (this.showEditDialog && this.editingAddress) {
        Column() {
          Column() {
            Text('编辑地址')
              .fontSize(18).fontWeight(600)
              .width('100%').textAlign(TextAlign.Center)
              .margin({ bottom: 16 })

            TextInput({ placeholder: '收货人姓名', text: this.editingAddress.name })
              .onChange(v => { if (this.editingAddress) this.editingAddress.name = v; })
              .margin({ bottom: 12 })

            TextInput({ placeholder: '手机号码', text: this.editingAddress.phone })
              .onChange(v => { if (this.editingAddress) this.editingAddress.phone = v; })
              .margin({ bottom: 12 })

            Row({ space: 8 }) {
              TextInput({ placeholder: '省', text: this.editingAddress.province })
                .layoutWeight(1).onChange(v => { if (this.editingAddress) this.editingAddress.province = v; })
              TextInput({ placeholder: '市', text: this.editingAddress.city })
                .layoutWeight(1).onChange(v => { if (this.editingAddress) this.editingAddress.city = v; })
              TextInput({ placeholder: '区', text: this.editingAddress.district })
                .layoutWeight(1).onChange(v => { if (this.editingAddress) this.editingAddress.district = v; })
            }

            TextInput({ placeholder: '详细地址', text: this.editingAddress.detail })
              .onChange(v => { if (this.editingAddress) this.editingAddress.detail = v; })
              .margin({ top: 12 })

            Row({ space: 12 }) {
              Button('取消')
                .layoutWeight(1)
                .onClick(() => {
                  this.showEditDialog = false;
                  this.editingAddress = null;
                })
              Button('保存')
                .layoutWeight(1)
                .backgroundColor('#007AFF')
                .onClick(() => this.handleSaveEditedAddress())
            }
            .margin({ top: 20 })

            //“设为默认地址”复选框
            Row() {
              Checkbox({ name: 'isDefault' })
                .select(this.editingAddress?.isDefault ?? false)
                .onChange((selected: boolean) => {
                  if (this.editingAddress) this.editingAddress.isDefault = selected;
                })
              Text('设为默认地址')
                .fontSize(14).fontColor('#333333')
            }
            .width('100%')
            .margin({ top: 12 })

          }
          .width('90%')
          .padding(20)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('rgba(0,0,0,0.5)')
        .position({ x: 0, y: 0 })
      }

    }
    .width('100%')
    .height('100%')
  }
}