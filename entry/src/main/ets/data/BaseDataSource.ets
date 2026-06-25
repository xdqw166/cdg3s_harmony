export abstract class BaseDataSource<T> implements IDataSource {
  protected data: T[] = []
  protected listeners: DataChangeListener[] = []

  totalCount(): number {
    return this.data.length
  }

  getData(index: number): T {
    return this.data[index]
  }

  getFullData(): T[] {
    return this.data
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener)
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener)
    if (pos >= 0) {
      this.listeners.splice(pos, 1)
    }
  }
}