#ifndef CARDWIDGET_H
#define CARDWIDGET_H

#include <QWidget>

namespace Ui {
class CardWidget;
}

class CardWidget : public QWidget {
  Q_OBJECT

 public:
  explicit CardWidget(const QString promo, QWidget *parent = nullptr);
  ~CardWidget();

  QString promo = "";

  void setPromo(const QString promo);
  const QString getPromo();
  void showPromo(const QString promo);

 private:
  Ui::CardWidget *ui;
};

#endif  // CARDWIDGET_H
